# frozen_string_literal: true

class GetDailyplanWithNewHouse
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(getdailyplan_updatehouse_request)
    Dry.Transaction(container: self) do
      step :update_house
      step :get_dailyplan
      step :return_value
    end.call(getdailyplan_updatehouse_request)
  end

  register :update_house, lambda { |params|
    update_result = async_house_update(params)
    Right(params)
  }

  register :get_dailyplan, lambda { |params|
    userEmail = params[:userEmail]
    project_id = params[:project_id]
    nthday = params[:nthday]
    http_result = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/project/#{userEmail}/#{project_id}/#{nthday}")
    if http_result.status == 200
      body = http_result.body
      dailyplan = JSON.parse(body)
      Right(body: body, params: params)
    else
      Left(Error.new('Failed GET request'))
    end
  }

  register :return_value, lambda { |input|
    plan = JSON.parse(input[:body])
    puts plan
    return_value = {
      "dailyplan_info" => plan["dailyplan_info"],
      "house_info" => {
        "roomId" => input[:params]["roomId"],
        "roomName" => input[:params]["roomName"],
        "roomPrice" => input[:params]["data.roomPrice"],
        "address" => input[:params]["data.address"],
        "airbnb_link" => input[:params]["data.airbnb_link"],
        "roomImg" => input[:params]["roomImg"],
        "bed" => input[:params]["bed"],
        "roomRank" => input[:params]["roomRank"],
      }
    }
    Right(return_value)
  }

  private_class_method

  def self.async_house_update(params)
    promised_update = Concurrent::Promise.execute {UpdateDailyplan.call(params)}
    promised_update
  end
end

# frozen_string_literal: true

class GetDailyplanWithNewHouse
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(getdailyplan_updatehouse_request)
    Dry.Transaction(container: self) do
      step :get_dailyplan
      step :update_house
    end.call(getdailyplan_updatehouse_request)
  end

  register :get_dailyplan, lambda { |params|
    userEmail = params[:userEmail]
    project_id = params[:project_id]
    nthday = params[:nthday]
    http_result = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/project/#{userEmail}/#{project_id}/#{nthday}")
    if http_result.status == 200
      body = http_result.body
      dailyplan = JSON.parse(body)
      Right(params)
    else
      Left(Error.new('Failed GET request'))
    end
  }

  register :update_house, lambda { |params|
    update_result = async_house_update(params)

    return_value = {
      "dailyplan_info" => {
          "project_id" => params["project_id"],
          "nthday" => params["nthday"],
          "date" => params["date"],
          "timeStart" => params["start"],
          "timeEnd" => params["end"],
          "locateStart" => params["origin"],
          "locateEnd" => params["destination"],
          "timeRemain" => params["timeRemain"],
        },
      "house_info" => {
        "roomId" => params["roomId"],
        "roomName" => params["roomName"],
        "roomPrice" => params["data.roomPrice"],
        "address" => params["data.address"],
        "airbnb_link" => params["data.airbnb_link"],
        "roomImg" => params["roomImg"],
        "bed" => params["bed"],
        "roomRank" => params["roomRank"],
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

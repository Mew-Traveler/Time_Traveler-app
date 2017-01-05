# frozen_string_literal: true

class UpdateDailyplan
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(update_dailyplan_request)
    Dry.Transaction(container: self) do
      step :post_new_dailyplan_to_api
    end.call(update_dailyplan_request)
  end


  register :post_new_dailyplan_to_api, lambda { |update_dailyplan_request|
    http_result = HTTP.post("#{TimeTravelerApp.config.Time_Traveler_API}/day/newroom/", 
      json: {
        dailyplanInfo: {
          project_id: update_dailyplan_request["project_id"],
          nthday: update_dailyplan_request["nthday"],
          roomId: update_dailyplan_request["roomId"],
          date: update_dailyplan_request["date"],
          timeStart: update_dailyplan_request["start"],
          timeEnd: update_dailyplan_request["end"],
          locateStart: update_dailyplan_request["origin"],
          locateEnd: update_dailyplan_request["destination"],
          timeRemain: "empty",
        }, 
        roomInfo: {
          id: update_dailyplan_request["roomId"],
          name: update_dailyplan_request["roomName"],
          price: update_dailyplan_request["roomPrice"],
          address: update_dailyplan_request["address"],
          airbnb_link: update_dailyplan_request["airbnb_link"],
          roomImg: update_dailyplan_request["roomImg"],
          bed: update_dailyplan_request["bed"],
          roomRank: update_dailyplan_request["roomRank"],
        }
      })
    if http_result.status == 200
      puts "post done!!!!!!!"
      body = http_result.body
      puts body

      Right(body)
    else
      puts "error in fact......."
      Left(Error.new('The mail must be used by others.'))
    end
  }
end
# frozen_string_literal: true

class GetDailyTarget
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(get_dailyplan_request)
    Dry.Transaction(container: self) do
      step :get_dailytarget_from_api
    end.call(get_dailyplan_request)
  end


  register :get_dailytarget_from_api, lambda { |get_dailytarget_request|

    project_id = get_dailytarget_request[:project_id]
    nthday = get_dailytarget_request[:nthday]
    http_result = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/addtarget/load/#{project_id}/#{nthday}/?")
    #http_result = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/project/#{userEmail}/#{project_id}/#{nthday}")
    puts "-------------------"

    puts http_result
    if http_result.status == 200
      body = http_result.body
      dailytarget = JSON.parse(body)

      Right(dailytarget)
    else
      Left(Error.new('dailytarget Error.'))
    end
  }
end

# frozen_string_literal: true

class GetProjectInfo
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(get_dailyplan_request)
    Dry.Transaction(container: self) do
      step :get_projectinfo_from_api
    end.call(get_dailyplan_request)
  end


  register :get_projectinfo_from_api, lambda { |get_dailyplan_request|
    project_id = get_dailyplan_request
    http_result = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/project/#{get_dailyplan_request}")
    if http_result.status == 200
      body = http_result.body

      prodays = JSON.parse(body.to_s)

      Right(prodays)
    else
      Left(Error.new('get project info error.'))
    end
  }
end

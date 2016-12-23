# frozen_string_literal: true

class CreateUser
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(get_dailyplan_request)
    Dry.Transaction(container: self) do
      step :get_dailyplan_from_api
    end.call(create_request)
  end


  register :call_api_to_create_user, lambda { |get_dailyplan_request|
    userEmail = get_dailyplan_request[:userEmail]
    project_id = get_dailyplan_request[:project_id]
    nthday = get_dailyplan_request[:nthday]
    http_result = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/project/#{userEmail}/#{project_id}/#{nthday}")
    if http_result.status == 200
      Right(http_result)
    else
      Left(Error.new('The mail must be used by others.'))
    end
  }
end
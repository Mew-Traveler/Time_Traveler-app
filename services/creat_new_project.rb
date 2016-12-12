# frozen_string_literal: true

# Gets list of all groups from API
class CreateNewProjectInfo
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :call_api_to_load_project
    end.call(url_request)
  end

  register :validate_url_request, lambda { |url_request|
    if url_request.success?
      Right(url_request)
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_load_project, lambda { |url_request|
    begin
      remain = url_request[:end].to_i - url_request[:start].to_i
      Right(HTTP.post("#{TimeTravelerApp.config.Time_Traveler_API}/myproject",
                      json: { projectName: params['projectName'], userEmail: params['userEmail'], dateEnd: params['dateEnd'],
                       dateStart: params['dateStart'] }))
    rescue
      Left(Error.new('Something Error in loading project '))
    end
  }
end

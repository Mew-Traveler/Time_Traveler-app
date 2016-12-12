# frozen_string_literal: true

# Gets list of all groups from API
class CreateUser
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :call_api_to_load_user
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

  register :call_api_to_load_user, lambda { |url_request|
    begin
      userEmail = url_request[:userEmail]
      Right(HTTP.post("#{TimeTravelerApp.config.Time_Traveler_API}/me/?",
                      json: { userEmail: userEmail}))
    rescue
      Left(Error.new('Something Error in registering /me '))
    end
  }
end

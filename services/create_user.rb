# frozen_string_literal: true

class CreateUser
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(create_request)
    Dry.Transaction(container: self) do
      step :validate_create_request
      step :call_api_to_create_user
    end.call(create_request)
  end

  register :validate_create_request, lambda { |create_request|
    if create_request.success?
      Right(create_request)
    else
      message = ErrorFlattener.new(
        ValidationError.new(create_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_create_user, lambda { |create_request|
    result = HTTP.post("#{TimeTravelerApp.config.TIME_TRAVELER_API}/createUser/",
                    json: { userEmail: create_request[:userEmail]})
    if result.status == 200
      Right(result)
    else
      Left(Error.new('The mail must be used by others.'))
    end
  }
end

# frozen_string_literal: true
CreateUserRequest = Dry::Validation.Form do
  required(:userEmail).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/create_request.yml')
  end
end

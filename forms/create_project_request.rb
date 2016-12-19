# frozen_string_literal: true
CreateProjectRequest = Dry::Validation.Form do
  required(:userEmail).filled
  required(:projectName).filled
  required(:dateStart).filled
  required(:dateEnd).filled

  configure do
    config.messages_file = File.join(__dir__, 'errors/create_request.yml')
  end
end

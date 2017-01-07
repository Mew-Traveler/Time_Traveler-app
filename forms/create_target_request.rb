# frozen_string_literal: true
CreateTargetRequest = Dry::Validation.Form do
  required(:project_id).filled
  required(:type).filled
  required(:rating).filled
  required(:site_name).filled
  required(:address).filled
  configure do
    config.messages_file = File.join(__dir__, 'errors/create_request.yml')
  end
end

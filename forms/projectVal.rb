# frozen_string_literal: true
ProjectVal = Dry::Validation.Form do
  required(:projectname).filled
  required(:fromdate).filled
  required(:todate).filled
  configure do
    config.messages_file = File.join(__dir__, 'errors/url_request.yml')
  end
end

# frozen_string_literal: true
ProfileVal = Dry::Validation.Form do
  required(:formEmail).filled
  configure do
    config.messages_file = File.join(__dir__, 'errors/url_request.yml')
  end
end

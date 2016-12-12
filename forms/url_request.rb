# frozen_string_literal: true
UrlRequest = Dry::Validation.Form do
  required(:end).filled
  required(:start).filled
  required(:origin).filled
  required(:destination).filled
  required(:formEmail).filled
  configure do
    config.messages_file = File.join(__dir__, 'errors/url_request.yml')
  end
end

# frozen_string_literal: true

# Gets list of all groups from API
class CreateNewTarget
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin
  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :call_api_to_load_daily
    end.call(url_request)
  end

  register :validate_url_request, lambda { |url_request|
    if url_request
      puts "url_request.success"
      puts url_request
      Right(url_request)
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_load_daily, lambda { |url_request|
    begin
      puts "url_request.call_api_to_load_dailybasic"
      params = JSON.parse(url_request.to_s)
      puts params
      Right(HTTP.post("#{TimeTravelerApp.config.TIME_TRAVELER_API}/dailyplan",
                      json: { type: params["type"], rating:params["rating"], address:params["address"], site_name: params["site_name"]}))

    rescue
      puts "error :("
      Left(Error.new('Something Error in loading dailybasic '))
    end
  }
end

# frozen_string_literal: true

# Gets list of all groups from API
class CreateNewDailyBasic
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin
  require 'time'
  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :call_api_to_load_dailybasic
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

  register :call_api_to_load_dailybasic, lambda { |url_request|
    begin
      puts "url_request.call_api_to_load_dailybasic"
      params = JSON.parse(url_request.to_s)
      puts params["roomId"]
      puts Time.parse(params["timeEnd"])
      remain = ((Time.parse(params["timeEnd"]) - Time.parse(params["timeStart"]))/3600).to_i
      puts remain

      Right(HTTP.post("#{TimeTravelerApp.config.Time_Traveler_API}/myproject/dailyplan",
                      json: { projectId: params["projectId"], roomId:params["roomId"], nthday:params["nthday"], timeStart: params["timeStart"],
                         timeEnd: params["timeEnd"],locateStart:params["locateStart"], locateEnd:params["locateEnd"],
                          timeRemain:remain }))

    rescue
      puts "error :("
      Left(Error.new('Something Error in loading dailybasic '))
    end
  }
end

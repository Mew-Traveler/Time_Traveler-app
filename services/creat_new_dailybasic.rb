# frozen_string_literal: true

# Gets list of all groups from API
class CreateNewDailyBasic
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :call_api_to_load_dailybasic
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

  register :call_api_to_load_dailybasic, lambda { |url_request|
    begin
      remain = url_request[:end].to_i - url_request[:start].to_i
      Right(HTTP.post("#{TimeTravelerApp.config.Time_Traveler_API}/myproject/dailyplan",
                      json: { projectId: "01", roomId:"0001", nthday:"1", timeStart: url_request[:start], timeEnd: url_request[:end],locateStart:url_request[:origin], locateEnd:url_request[:destination], timeRemain:remain }))
    rescue
      Left(Error.new('Something Error in loading dailybasic '))
    end
  }
end

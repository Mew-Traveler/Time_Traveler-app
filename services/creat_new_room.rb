# frozen_string_literal: true

# Gets list of all groups from API
class CreateNewRoom
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :tmp_getdata_request
      #step :call_api_to_load_group
      #step :return_api_result
    end.call(url_request)
  end

  register :tmp_getdata_request, lambda { |url_request|
    print 'ua'
    if url_request.success?
      Right(HTTP.get("https://api.airbnb.com/v2/search_results?client_id=3092nxybyb0otqw18e8nh5nty&location=#{url_request}"))
      print HTTP.get("https://api.airbnb.com/v2/search_results?client_id=3092nxybyb0otqw18e8nh5nty&location=#{url_request}") 
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :validate_url_request, lambda { |url_request|
    if url_request.success?
      Right(url_request[:live_location])
    else
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_load_rooms, lambda { |locate|
    begin
      Right(HTTP.post("#{TimeTravelerApp.config.Time_Traveler_API}/rent",
                      json: { location: locate }))
    rescue
      Left(Error.new('Our servers failed - we are investigating!'))
    end
  }

  register :return_api_result, lambda { |http_result|
    data = http_result.body.to_s
    if http_result.status == 200
      Right(RentRepresenter.new(Rent.new).from_json(data))
    else
      message = ErrorFlattener.new(
        ApiErrorRepresenter.new(ApiError.new).from_json(data)
      ).to_s
      Left(Error.new(message))
    end
  }
  private_class_method

  def self.get_url(title)
    "https://api.airbnb.com/v2/search_results?client_id=3092nxybyb0otqw18e8nh5nty&location=#{title.gsub(/ /, '+')}&y=&plot=short&r=json"
  end
end

# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :tmpView
  end

  post '/location/?' do
    location = UrlRequest.call(params)
    result = GetLocationHotel.call(location)
    if result.success?
       @data = result.value
    else
       flash[:error] = result.value.message
    end
    
    # redirect '/'
  end
end

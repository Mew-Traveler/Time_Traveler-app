# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :login
  end
  get "/rent/?" do

    # url_request = CreateNewRoom.call()
    result = TimeTraveler.call(params[:live_location])

        # result = TimeTraveler.call(body_params['city'])
    # result = TimeTraveler.call
    print result
    if result.success?
      @data = result.value
      print @data
      flash[:notice] = 'Here is the information'

    else
      flash[:error] = result.value.message
    end
    slim :project_rent
  end

  post "/daily/basic/?" do
    url_request = UrlRequest.call(params)
    result = CreateNewDailyBasic.call(url_request)
    if result.success?
      print "hihihi"
      flash[:notice] = 'Basic daily successfully added'
    else
      flash[:error] = result.value.message
    end
    redirect '/'
  end

  post '/location/?' do
    location = UrlRequest.call(params)
    result = GetLocationHotel.call(location)
    if result.success?
       flash[:notice] = 'Return the result with the location'
    else
       flash[:error] = result.value.message
    end

    # redirect '/'
  end
end

# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base
  # get "/?" do
  #   slim :project_rent
  # end
  get "/rent/?" do

    # url_request = CreateNewRoom.call()
    result = RentInfoClass.call(params[:live_location])
    @timediff = params[:timedif].to_i
    @nthday = params[:nthday]
    @ids = params[:ids]
    puts "rlihwlirhglihlrihglwkhlrkhlwrkhglwirhlwi"

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
    print "=========daily/basic========"
    # puts request.body.read
    url_request = request.body.read
    # puts JSON.parse(request.body)
    # url_request = UrlRequest.call(url_request)
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

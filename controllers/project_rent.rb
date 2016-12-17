# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base
  # get "/?" do
  #   slim :project_rent
  # end
  get "/rent/?" do

    # url_request = CreateNewRoom.call()
    result = RentInfoClass.call(params[:live_location])
    puts params
    @timediff = params[:timedif].to_i
    @nthday = params[:nthday]
    @ids = params[:projectid]
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
    url_request = request.body.read
    result = CreateNewDailyBasic.call(url_request)

    if result.success?
      print "hihihi"
      flash[:notice] = 'Basic daily successfully added'
      content_type 'application/json'
      result.value.body
    else
      flash[:error] = result.value.message
    end
    # redirect "/teseeet/?"

  end

  get "/buildshedule/:proId/Nday?" do
    puts "----teseeet----"
    puts params
    slim :scharrange
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

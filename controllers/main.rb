class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :main
  end

  post "/user/?" do
    url_request = UrlRequest.call(params)
    result = CreateUser.call(url_request)
    if result.success?
      print "CreateUser"
      flash[:notice] = 'Basic user successfully added'
    else
      flash[:error] = result.value.message
    end
    slim :projectpool
  end
end

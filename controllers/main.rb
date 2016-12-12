class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :main
  end

  post "/user/?" do
    url_request = ProfileVal.call(params)
    puts url_request
    result = CreateUser.call(url_request)
    if result.success?
      flash[:notice] = 'Basic user successfully added'
    else
      flash[:error] = result.value.message
    end
    @email = url_request[:formEmail]
    slim :projectpool
  end
end

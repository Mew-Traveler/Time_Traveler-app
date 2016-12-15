class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :login
  end

  get "/login/?" do
  	userEmail = params[:userEmail]
  	result = LogIn.call(userEmail)
  	if result.success?
  	else
      flash[:error] = result.value.message
      redirect '/?'
  	end

  	slim :lobby
  end

  post "/create/?" do
    mail = params[:email]
  end
end
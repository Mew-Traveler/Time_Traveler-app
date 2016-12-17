class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :login
  end

  get "/login/?" do
  	userEmail = params[:userEmail]
  	result = LogIn.call(userEmail)
  	if result.success?
      @all_projects = result.value
  	else
      puts result.success?
      flash[:error] = result.value.message
      redirect '/?'
  	end

  	slim :lobby
  end
end
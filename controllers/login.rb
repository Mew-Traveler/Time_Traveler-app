class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :login
  end

  get "/login/?" do
  	userEmail = params[:userEmail]
  	result = LogIn.call(userEmail)
  	if result.success?
      @all_projects = result.value
      @user = userEmail
  	else
      puts result.success?
      flash[:error] = result.value.message
      redirect '/?'
  	end

  	slim :lobby
  end

  post "/newUser/?" do
    create_request = CreateUserRequest.call(params)
    puts create_request[:userEmail]
    puts "!!!!!!!!!!!!!!"
    result = CreateUser.call(create_request)
    if result.success?
      @all_projects = nil
      @user = create_request[:userEmail]
    else
      flash[:error] = result.value.message
      redirect '/?'      
    end

    slim :lobby
  end
end
class TimeTravelerApp < Sinatra::Base

  get "/goto/project/?" do
    puts "here i amamamamamamamama"
    puts params
  	# userEmail = params[:userEmail]
  	# result = LogIn.call(userEmail)
  	# if result.success?
   #    @all_projects = result.value
   #    @user = userEmail
  	# else
   #    puts result.success?
   #    flash[:error] = result.value.message
   #    redirect '/?'
  	# end

  	# slim :lobby
  end
end
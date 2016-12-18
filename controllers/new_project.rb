class TimeTravelerApp < Sinatra::Base

  post "/create/newProject/?" do
    puts params[:userEmail]
    slim :project_rent
  end
end
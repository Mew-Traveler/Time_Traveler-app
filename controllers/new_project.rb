class TimeTravelerApp < Sinatra::Base

  post "/create/newProject/?" do
    puts "YYYYYYYYYYYYYYYYYY"
    slim :project_rent
  end
end
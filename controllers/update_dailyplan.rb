class TimeTravelerApp < Sinatra::Base

  post "/update/dailyplan/?" do
    puts params
    puts params["origin"]
    update_result = UpdateDailyplan.call(params)
  end
end
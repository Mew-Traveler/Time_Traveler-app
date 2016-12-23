class TimeTravelerApp < Sinatra::Base

  get "/goto/project/?" do
    puts params
    
    @projectName = params[:projectName]
    @totalDays = params[:projectDays]
    @userEmail = params[:userEmail]
    #dailyplan = GetDailyplan.call(params)
    
    slim :project_rent
  end
end
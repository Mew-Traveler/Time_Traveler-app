class TimeTravelerApp < Sinatra::Base

  get "/goto/project/?" do
    puts params
    
    @projectName = params[:projectName]
    @totalDays = params[:projectDays]
    @userEmail = params[:userEmail]
    result = GetDailyplan.call(params)
    
    if result.success?
       dailyplan = result.value
       @dailyplan_info = dailyplan["dailyplan_info"]
       @house_info = dailyplan["house_info"]
       puts @house_info
    else

    end

    slim :project_rent
  end
end
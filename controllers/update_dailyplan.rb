class TimeTravelerApp < Sinatra::Base

  post "/update/dailyplan/?" do
    puts params
    update_result = UpdateDailyplan.call(params)
    reload_result = GetDailyplan.call(params)
 
    @projectName = params[:projectName]
    @totalDays = params[:projectDays]
    @userEmail = params[:userEmail]
    @nthday = params[:nthday]
    @project_id = params[:project_id] 
      
    if reload_result.success?
       dailyplan = reload_result.value
       @dailyplan_info = dailyplan["dailyplan_info"]
       @house_info = dailyplan["house_info"]
       puts @dailyplan_info
       puts @house_info
    else
      puts "wrong params"
    end

    slim :project_rent
  end
end
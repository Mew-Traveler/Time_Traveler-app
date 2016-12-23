class TimeTravelerApp < Sinatra::Base

  get "/goto/project/?" do
    puts params
    
    @projectName = params[:projectName]
    @totalDays = params[:projectDays]
    @userEmail = params[:userEmail]
    @nthday = params[:nthday]
    @project_id = params[:project_id]
    result = GetDailyplan.call(params)
    
    if result.success?
       dailyplan = result.value
       @dailyplan_info = dailyplan["dailyplan_info"]
       # @house_info = dailyplan["house_info"]
       puts @dailyplan_info
    else
      puts "wrong params"
    end

    slim :project_rent
  end
end
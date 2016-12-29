class TimeTravelerApp < Sinatra::Base

  post "/create/newProject/?" do
    @projectName = params[:projectName]
    @userEmail = params[:userEmail]
    @nthday = "1"  

    create_request = CreateProjectRequest.call(params)
    new_result = CreateProject.call(create_request)

    project = new_result.value
    @totalDays = project.projects[0][:day]
    @project_id = project.projects[0][:id]

    params[:nthday] = @nthday
    params[:project_id] = @project_id
    params[:projectDays] = @totalDays

    get_result = GetDailyplan.call(params)
    if new_result.success?
      dailyplan = get_result.value
      @dailyplan_info = dailyplan["dailyplan_info"]
      @house_info = dailyplan["house_info"]
  
      slim :project_rent
    else
      flash[:error] = result.value.message
    end
  end
end
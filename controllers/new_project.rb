class TimeTravelerApp < Sinatra::Base
  require 'date'

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
      project = new_result.value
      @totalDays = (Date.parse(params[:endtiming])- Date.parse(params[:starttiming])).to_i

      flash[:notice] = 'Group successfully added'

      result = LogIn.call(params['userEmail'])
      if result.success?
        @all_projects = result.value
        @user = params['userEmail']
        slim :lobby
      else
        flash[:error] = result.value.message
      end
    else
      flash[:error] = new_result.value.message
    end
  end
end

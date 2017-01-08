class TimeTravelerApp < Sinatra::Base
  require 'date'

  post "/create/newProject/?" do
    @projectName = params[:projectName]
    @userEmail = params[:userEmail]
    @nthday = "1"

    create_request = CreateProjectRequest.call(params)
    new_result = CreateProject.call(create_request)

    project = new_result.value
    puts create_request[:endtiming]

    @totalDays = (Date.parse(create_request[:endtiming])- Date.parse(params[:starttiming])).to_i
    @project_id = project.projects[0][:id]

    params[:nthday] = @nthday
    params[:project_id] = @project_id
    params[:projectDays] = @totalDays

    get_result = GetDailyplan.call(params)
    if new_result.success?
      project = new_result.value

      flash[:notice] = 'Project successfully added'

      result = LogIn.call(params['userEmail'])
      if result.success?
        @all_projects = result.value
        @user = params['userEmail']
        @totalDays = params[:projectDays]
        slim :lobby
      else
        flash[:error] = result.value.message
      end
    else
      flash[:error] = new_result.value.message
    end
  end
end

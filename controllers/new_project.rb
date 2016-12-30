class TimeTravelerApp < Sinatra::Base
  require 'date'

  post "/create/newProject/?" do
    create_request = CreateProjectRequest.call(params)
    new_result = CreateProject.call(create_request)
    if new_result.success?
      project = new_result.value
      puts project.projects[0][:day]
      puts project.projects[0][:projectName]
      # @totalDays = project.projects[0][:day]
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
      #slim :project_rent
    else
      flash[:error] = new_result.value.message
    end
  end
end

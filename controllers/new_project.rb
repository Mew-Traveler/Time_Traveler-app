class TimeTravelerApp < Sinatra::Base

  post "/create/newProject/?" do
    create_request = CreateProjectRequest.call(params)
    new_result = CreateProject.call(create_request)
    if new_result.success?
      puts "the last"
      project = new_result.value
      puts project.projects[0][:day]
      puts project.projects[0][:projectName]
      @totalDays = project.projects[0][:day]
      # flash[:notice] = 'Group successfully added'
      slim :project_rent
    else
      flash[:error] = result.value.message
    end
  end
end
class TimeTravelerApp < Sinatra::Base

  post "/create/newProject/?" do
    create_request = CreateRequest.call(params)
    result = CreateProject.call(create_request)

    if result.success?
      @projectInfo = params
      @project = result.value
      # flash[:notice] = 'Group successfully added'
    else
      flash[:error] = result.value.message
    end
  end
end
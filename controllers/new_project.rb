class TimeTravelerApp < Sinatra::Base

  post "/create/newProject/?" do
    create_request = CreateRequest.call(params)
    result = CreateProject.call(create_request)

    if result.success?
      # flash[:notice] = 'Group successfully added'
      slim :project_rent
    else
      flash[:error] = result.value.message
    end
  end
end
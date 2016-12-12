class TimeTravelerApp < Sinatra::Base
  get "/projects?" do
    slim :projectpool
  end

  post "/projectInfo/?" do
    url_request = ProjectVal.call(params)
    result = CreateNewProjectInfo.call(url_request)
    if result.success?
      flash[:notice] = 'Basic project successfully added'
    else
      flash[:error] = result.value.message
    end
    slim :projectpool
  end
end

class TimeTravelerApp < Sinatra::Base
  get "/projects/:email/?" do
    puts "/projects"
    puts params[:email]
    @user = params[:email]
    result = LoadProjects.call(@user)
    if result.success?
      myproject = JSON.parse(result.value)
      @projectinfo = myproject.map do |project|
        {name:project['projectName'], id:project['id']}
      end

    else
      flash[:error] = result.value.message
    end
    slim :projectpool
  end

  post "/projectInfo/?" do
    url_request = ProjectVal.call(params)
    puts "projectpool/"
    puts url_request[:projectname]
    @user = url_request[:user]
    result = CreateNewProjectInfo.call(url_request)
    if result.success?
      flash[:notice] = 'Basic project successfully added'
    else
      flash[:error] = result.value.message
    end
    redirect "/projects/#{@user}/?"
  end

  get "/projects/:projectId?" do

  end
end

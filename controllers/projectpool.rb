class TimeTravelerApp < Sinatra::Base
  require 'date'
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
    puts "----time difference----"
    puts (Date.parse(params[:todate])- Date.parse(params[:fromdate])).to_i
    @timeDiffer = (Date.parse(url_request[:todate])- Date.parse(url_request[:fromdate])).to_i
    @user = url_request[:user]
    result = CreateNewProjectInfo.call(url_request)
    if result.success?
      flash[:notice] = 'Basic project successfully added'
    else
      flash[:error] = result.value.message
    end
    redirect "/projects/#{@user}/?"
  end

  # get "/projects/:projectId?/" do
  #
  # end

  get "/myprojects/:projectId/?" do
    @timedif = 0;
    # puts params
    # puts params[:projectId]
    # @timediff = params[:timediff].to_i
    # puts (Date.parse(params[:todate])- Date.parse(params[:fromdate])).to_i
    result = LoadProjectInfo.call(params[:projectId])
    puts result.value


    if result.success?
      Infoma = JSON.parse(result.value)
      info = Infoma.map do |infom|
        @timediff = (Date.parse(infom["projectEnd"])- Date.parse(infom["projectStart"])).to_i
      end
      # ends = Date.parse(Infoma["projectEnd"])

      # @timediff = (Date.parse(Infoma[0]["projectEnd"])- Date.parse(Infoma[0]["projectStart"])).to_i
      # [{"id":8,"projectName":"directTo","projectStart":"2016-12-14 10:00","projectEnd":"2016-12-21 14:25"}]
      flash[:notice] = 'Basic info of project successfully load'
    else
      flash[:error] = result.value.message
    end
    slim :project_rent
  end

end

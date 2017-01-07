# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base

  get "/planifica/" do
    puts "---------"
    puts params
    slim :addtarget

  end
  get "/planificac/find/:query/?" do
    puts "-----hello----"
    puts params[:type]

    result = LoadGoogleResults.call(params[:query],params[:type])
    if result.success?
      flash[:notice] = 'Here is the information'
    #
      content_type 'application/json'
      puts result.value
      result.value

    else
      flash[:error] = result.value.message
    end
  end

  get "/planificac/route/:query/?" do
    puts "-----hello----"
    puts params

  end

  get "/planificac/cancel/"do
    puts "-----planificac/cancel-------"
    slim :project_rent
  end

  post "/planificac/create/?" do
    puts 'post "/planificac/create/?" do'
    url_request = request.body.read
    puts url_request
    # create_request = CreateTargetRequest.call(params)
    target_result = CreateNewTarget.call(url_request)

    target = target_result.value
    puts "*****"
    puts target
    # create_request = CreateProjectRequest.call(params)
    # new_result = CreateProject.call(create_request)
    #
    # project = new_result.value
    # @totalDays = project.projects[0][:day]
    # @project_id = project.projects[0][:id]
    #
    # params[:nthday] = @nthday
    # params[:project_id] = @project_id
    # params[:projectDays] = @totalDays
    #
    # get_result = GetDailyplan.call(params)
    # if new_result.success?
    #   project = new_result.value
    #   @totalDays = (Date.parse(params[:endtiming])- Date.parse(params[:starttiming])).to_i
    #
    #   flash[:notice] = 'Group successfully added'
    #
    #   result = LogIn.call(params['userEmail'])
    #   if result.success?
    #     @all_projects = result.value
    #     @user = params['userEmail']
    #     slim :lobby
    #   else
    #     flash[:error] = result.value.message
    #   end
    # else
    #   flash[:error] = new_result.value.message
    # end
  end

end

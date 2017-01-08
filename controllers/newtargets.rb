# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base

  get "/planifica/?" do
    puts "---------"
    puts params
    @projectName = params[:projectName]
    @totalDays = params[:projectDays]
    @userEmail = params[:userEmail]
    @nthday = params[:nthday]
    @project_id = params[:project_id]

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
    target_result = CreateNewTarget.call(url_request)

    target = target_result.value
  end

end

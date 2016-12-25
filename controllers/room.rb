# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base
  # Home page: show list of all pages
  get '/room/?' do
    puts "show_hotels get params:"
    puts params
    @userEmail = params['userEmail']
    @totalDays = params['projectDays']
    @projectName = params['projectName']
    @project_id = params['project_id']
    @date = params['date']
    @nthday = params['nthday']
    @origin = params['origin']
    @destination = params['destination']
    @start = params['start']
    @end = params['end']
    location = params['location']
    result = GetAllRooms.call(location)
    if result.success?
      @data = result.value
    else
      flash[:error] = result.value.message
    end

    slim :show_hotels
  end

end

# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base
  # Home page: show list of all pages
  get '/room/?' do
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

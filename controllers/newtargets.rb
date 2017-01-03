# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base

  get "/planificac/find/:query/?" do
    slim :addtarget
    # puts params
    #
    # puts url.split("?")[1]
    # result = LoadGoogleResults.call(params[:query],params[:type])
    # if result.success?
    #   flash[:notice] = 'Here is the information'
    #
    #   content_type 'application/json'
    #   puts result.value
    #   result.value
      # @googldres = result.value
      # puts @googldres
      # print @googldres["name"]

    # else
    #   flash[:error] = result.value.message
    # end
  end
end

# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base

  get "/planificac/find/:query/?" do
    puts params

    puts url.split("?")[1]
    result = LoadGoogleResults.call(params[:query],params[:type])
    if result.success?
      @googldres = result.value
      # print @googldres["name"]
      flash[:notice] = 'Here is the information'

    else
      flash[:error] = result.value.message
    end
    slim :newatracciones
    # puts params
    # @timediff = params[:timedif].to_i
    # @nthday = params[:nthday]
    # @ids = params[:projectid]
    # puts "rlihwlirhglihlrihglwkhlrkhlwrkhglwirhlwi"

    # if result.success?
    #   # @data = result.value
    #   # print @data
    #   flash[:notice] = 'Here is the information'
    #
    # else
    #   flash[:error] = result.value.message
    # end
    # slim :newatracciones
  end
end

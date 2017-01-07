# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base

  get "/planifica/" do
    puts "---------"
    puts params
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
  get "/planificac/find/:query/?" do
    puts "-----hello----"
    puts params[:type]
    #slim :addtarget
    # puts params
    #
    # puts url.split("?")[1]
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
end

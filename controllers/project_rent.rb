# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :project_rent
  end
  get "/rent/?" do
    print "project_rent"
    print params.to_s

    # url_request = CreateNewRoom.call()
    result = TimeTraveler.call(params[:live_location])

        # result = TimeTraveler.call(body_params['city'])
    # result = TimeTraveler.call
    print result
    if result.success?
      @data = result.value
      print @data
      flash[:notice] = 'Here is the information'

    else
      flash[:error] = result.value.message
    end
    slim :project_rent
  end
end

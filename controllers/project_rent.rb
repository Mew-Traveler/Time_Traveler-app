# frozen_string_literal: true

# TimeTraveler web service
class TimeTravelerApp < Sinatra::Base
  get "/?" do
    result = TimeTraveler.call
    if result.success?
      @data = result.value
    else
      flash[:error] = result.value.message
    end
  end
  slim :project_rent
end

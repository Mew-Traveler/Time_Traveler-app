# frozen_string_literal: true

# MovlogAPI web service
class MovlogApp < Sinatra::Base
  get "/?" do
    result = TimeTraveler.call
    if result.success?
      @data = result.value
    else
      flash[:error] = result.value.message
  end

  slim: project_rent
end
# frozen_string_literal: true

# MovlogAPI web service
class MovlogApp < Sinatra::Base
  get "/?" do
    "TimeTraveler"
  end

end
class TimeTravelerApp < Sinatra::Base
  get "/?" do
    slim :main
  end
end

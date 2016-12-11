class TimeTravelerApp < Sinatra::Base
  get "/projects?" do
    slim :projectpool
  end
end

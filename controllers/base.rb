#configure based on environment
class MovlogApp < Sinatra::Base
  extend Econfig::Shortcut

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
    Skyscanner::SkyscannerApi.config.update(skyscanner_id: config.SKYSCANNER_API)
    Airbnb::AirbnbApi.config.update(airbnb_id: config.AIRBNB_API)
    Google::GoogleApi.config.update(googlemap_id: config.GOOGLE_API)
  end

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  after do
    content_type 'text/html'
  end
end
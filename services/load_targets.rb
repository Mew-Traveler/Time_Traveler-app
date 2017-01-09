
# frozen_string_literal: true

# Gets list of all groups from API

require 'json'
class LoadGoogleResults
  extend Dry::Monads::Either::Mixin

  def self.call(query,type)
    puts "-----LoadGoogleResults---------"
    puts query
    begin
      results = HTTP.get("#{TimeTravelerApp.config.TIME_TRAVELER_API}/dailyplan/findSite/#{query}+#{type}")
      puts results.body.to_s
      Right(results.body.to_s)

      # Right(AtraccionesRepresenter.new(Atracciones.new)
      #                        .from_json(results.body.to_s))
    rescue
      puts "Oops LoadGoogleResults"
      Left(Error.new('Something Error n LoadProjects.'))
    end
  end
end

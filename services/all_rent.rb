# frozen_string_literal: true

# Gets list of all groups from API
require 'json'
class TimeTraveler
  extend Dry::Monads::Either::Mixin

  def self.call(locate)
    print "locate call"

    results = HTTP.get("#{TimeTravelerApp.config.TIME_TRAVELER_API}/rent/#{locate}")
    Right(RentsRepresenter.new(Rents.new)
                           .from_json(results.body))
    #Right(roomsInfo)
  rescue
    Left(Error.new('Something Error.'))
  end
end

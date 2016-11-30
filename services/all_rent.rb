# frozen_string_literal: true

# Gets list of all groups from API
require 'json'
class TimeTraveler
  extend Dry::Monads::Either::Mixin

  def self.call(locate)
    print "locate call"

    results = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/rent/#{locate}")
    resultsToS = results.body.to_s
    my_hash = JSON.parse(resultsToS)
    roomsInfo = my_hash["infos"]
    # testdev = {rents: roomsInfo.to_s}.to_json
    print results
    # infos = resultsToJSON["infos"][0]
    # print "infos: \n"
    # print resultsToJSON
    puts
    #Right(RentsRepresenter.new(Rents.new)
    #                       .from_json(JSON.parse(roomsInfo)))
    Right(roomsInfo)
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end

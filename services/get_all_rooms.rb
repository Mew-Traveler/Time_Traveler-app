# frozen_string_literal: true

# Gets list of all pages from API
class GetAllRooms
  extend Dry::Monads::Either::Mixin

  def self.call(location)
    results = HTTP.get("#{TimeTravelerApp.config.TIME_TRAVELER_API}/getHouses/#{location}")
    Right(RentsRepresenter.new(Rents.new).from_json(results.body))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end

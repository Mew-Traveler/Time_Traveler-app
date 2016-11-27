# frozen_string_literal: true

# Gets list of all groups from API
class TimeTraveler
  extend Dry::Monads::Either::Mixin

  def self.call
    results = HTTP.get("#{TimeTraveler.config.AIRBNB_API}/Hsinch")
    Right(RentRepresenter.new(Rent.new)
                           .from_json(results.body))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end
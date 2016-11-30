# frozen_string_literal: true

# Represents overall group information for JSON API output
class RentRepresenter < Roar::Decorator
  include Roar::JSON

  property :id
  property :name
  property :pic_url
  property :city

end

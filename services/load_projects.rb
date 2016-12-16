
# frozen_string_literal: true

# Gets list of all groups from API

require 'json'
class LoadProjects
  extend Dry::Monads::Either::Mixin

  def self.call(user)
    puts "-----LoadProjects---------"
    results = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/me/#{user}")
    puts results.body
    if (results.status.code != '404')
      Right(results.body)
    else
      Left(Error.new("result is 404"))
    end
    #Right(roomsInfo)
  rescue
    puts "Oops"
    Left(Error.new('Something Error n LoadProjects.'))
  end
end

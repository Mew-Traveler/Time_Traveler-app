
# frozen_string_literal: true

# Gets list of all groups from API

require 'json'
class LoadProjectInfo
  extend Dry::Monads::Either::Mixin

  def self.call(projectId)
    puts "-----LoadProjectInfo---------"
    puts projectId
    results = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/myproject/#{projectId}")
    puts results.body
    if (results.status.code != '404')
      Right(results.body.to_s)
    else
      Left(Error.new("result is 404"))
    end
    #Right(roomsInfo)
  rescue
    puts "Oops"
    Left(Error.new('Something Error n LoadProjects.'))
  end
end

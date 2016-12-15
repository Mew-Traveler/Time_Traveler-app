# frozen_string_literal: true

class LogIn
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(userEmail)
    Dry.Transaction(container: self) do
      step :go_login
      step :validate_exist
    end.call(userEmail)
  end

  register :go_login, lambda { |userEmail|
    begin
      result = HTTP.get("#{TimeTravelerApp.config.Time_Traveler_API}/me/#{userEmail}")
      Right(result)
    rescue
      Left(Error.new('Something error for LogIn request.'))
    end
  }

  register :validate_exist, lambda { |http_result|
  	puts "here I am~~~~~"
  	data = http_result.body.to_s
    if http_result.status == 200
      puts "fuck you"
      Right(result)
    else
      Left(Error.new('The #{email} dosen\'t exist.'))
    end
  }
end
# frozen_string_literal: true

class LogIn
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(userEmail)
    Dry.Transaction(container: self) do
      step :go_login
      step :validate_account_exist
      step :get_all_exist_projects
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

  register :validate_account_exist, lambda { |http_result|
    puts "YOOOOOO"
    # puts http_result.body.to_s
    if http_result.status == 200
      Right(http_result)
    else
      puts "fuck you"
      Left(Error.new('The #{email} dosen\'t exist.'))
    end
  }

  register :get_all_exist_projects, lambda { |results|
  	begin
  	  puts "here is results' body"
  	  puts results.body

  	  Right(ProjectsRepresenter.new(Projects.new).from_json(results.body))
    rescue
      Left(Error.new('wrong for passing value in get all exist projects'))
    end
  }
end

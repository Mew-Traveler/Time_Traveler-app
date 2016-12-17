# frozen_string_literal: true

# Gets list of all groups from API
class CreateNewProjectInfo
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin
  require 'time'
  require 'date'


  def self.call(url_request)
    Dry.Transaction(container: self) do
      step :validate_url_request
      step :call_api_to_load_project
    end.call(url_request)
  end

  register :validate_url_request, lambda { |url_request|
    puts "-----validate_url_request----"
    puts url_request[:fromdate]
    if url_request.success?
      puts "url_request.success?"
      Right(url_request)
    else
      puts "else-url_request.success?"
      message = ErrorFlattener.new(
        ValidationError.new(url_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_load_project, lambda { |params|
    begin
      puts "call-load-project"
      puts params[:projectname]
      Right(HTTP.post("#{TimeTravelerApp.config.Time_Traveler_API}/myproject",
                      json: { projectName: params[:projectname], userEmail: params[:user], dateEnd: params[:todate],
                       dateStart: params[:fromdate] }))


    rescue
      puts "Something Error in loading project"
      Left(Error.new('Something Error in loading project '))
    end
  }
end

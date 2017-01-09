# frozen_string_literal: true

class CreateProject
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(create_request)
    Dry.Transaction(container: self) do
      step :validate_create_request
      step :call_api_to_create_project
      # step :return_create_result
    end.call(create_request)
  end

  register :validate_create_request, lambda { |create_request|
    if create_request.success?
      Right(create_request)
    else
      message = ErrorFlattener.new(
        ValidationError.new(create_request)
      ).to_s
      Left(Error.new(message))
    end
  }

  register :call_api_to_create_project, lambda { |create_request|
    http_result = HTTP.post("#{TimeTravelerApp.config.TIME_TRAVELER_API}/project/create/",
                    json: { userEmail: create_request[:userEmail], projectName: create_request[:projectName], dateStart: create_request[:starttiming], dateEnd: create_request[:endtiming]})
    if http_result.status == 200
       Right(ProjectsRepresenter.new(Projects.new).from_json(http_result.body))
    else
      Left(Error.new('The create request failed.'))
    end
  }

  # register :return_create_result, lambda { |results|
  # 	begin
  # 	  puts "here is results' body"
  # 	  puts results.body
  # 	  puts results.body.to_json
  # 	  Right(ProjectsRepresenter.new(Projects.new).from_json(results.body))
  #   rescue
  #     Left(Error.new('wrong for passing value'))
  #   end
  # }
end

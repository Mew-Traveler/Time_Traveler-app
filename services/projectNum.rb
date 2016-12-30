# frozen_string_literal: true

class ProjectNum
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(userEmail)
    Dry.Transaction(container: self) do
      step :get_all_exist_projects
    end.call(userEmail)
  end


  register :get_all_exist_projects, lambda { |userEmail|
  	begin
  	  Right(ProjectsRepresenter.new(Projects.new).from_json(userEmail))
    rescue
      Left(Error.new('wrong for passing value in get all exist projects'))
    end
  }
end

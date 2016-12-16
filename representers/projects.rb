# frozen_string_literal: true
require_relative 'rent'

# Represents overall group information for JSON API output
class ProjectsRepresenter < Roar::Decorator
  include Roar::JSON

  collection :projects, extend: ProjectRepresenter, class: Project
end

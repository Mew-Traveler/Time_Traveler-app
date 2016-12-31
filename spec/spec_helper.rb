# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'

require 'watir'
require 'headless'
require 'page-object'

require './init.rb'


HOST = 'http://localhost:3000/'
NEW_USER_EMAIL = 'specman@gmail.com'

# Helper methods
def homepage
  HOST
end

def group_details_page(id)
  "#{HOST}/groups/#{id}"
end

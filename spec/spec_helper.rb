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
NEW_PROJECT_NAME = 'specProject1'
NEW_PROJECT_DATE_START = '1/1'
NEW_PROJECT_DATE_END = '1/7'
DAY1_LOCATION = 'Hsinchu'
DAY2_LOCATION = 'Taipei'
DAY3_LOCATION = 'Yilan'
DAY4_LOCATION = 'Hualien'
DAY5_LOCATION = 'Taitung'
DAY6_LOCATION = 'Pingtung'
DAY7_LOCATION = 'Tainan'
DAY1_ORIGIN = 'Taitung'
DAY1_DESTINATION = 'Hsinchu'
DAY1_START = '7:00'
DAY1_END = '18:30'

# Helper methods
def homepage
  HOST
end

def group_details_page(id)
  "#{HOST}/groups/#{id}"
end

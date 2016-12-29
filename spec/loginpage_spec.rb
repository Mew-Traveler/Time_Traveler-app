# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Login Page' do
  before do
    unless @browser
      # @headless = Headless.new
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Page elements' do
    it '(HAPPY) should see login page features' do
      # GIVEN
      @browser.goto homepage
      @browser.title.must_include 'TimeTravelerApp'

      # THEN
      @browser.button(name: 'HaveAccount').visible?.must_equal true
    end

    
  end
end

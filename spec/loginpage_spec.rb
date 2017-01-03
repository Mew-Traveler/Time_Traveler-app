# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Login Page' do
  before do
    unless @browser
      # @headless = Headless.new
      @browser = Watir::Browser.new
      @browser.goto homepage
      @browser.button(name: 'New').click
      @browser.button(name: 'HaveAccount').click
    end
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Login Page' do
    it '(HAPPY) should see login page features' do
      # GIVEN
      @browser.title.must_include 'TimeTravelerApp'

      # THEN
      @browser.button(name: 'HaveAccount').visible?.must_equal true
      @browser.button(name: 'New').visible?.must_equal true
      @browser.input(id: 'userEmail1').visible?.must_equal true
      @browser.input(id: 'userEmail2').visible?.must_equal true
      @browser.button(name: 'btn_newUser').visible?.must_equal true
      @browser.button(name: 'btn_login').visible?.must_equal true
      
    end

    it '(HAPPY) should be able to create a new account and login success' do
      # Create a new account
      @browser.input(id: 'userEmail2').visible?.must_equal true
      @browser.button(name: 'btn_newUser').visible?.must_equal true
      @browser.button(name: 'btn_login').visible?.must_equal true
      @browser.text_field(id: 'userEmail2').set(NEW_USER_EMAIL)
      @browser.button(name: 'btn_newUser').click

      # Login by the new account
      @browser.button(name: 'HaveAccount').click
      Watir::Wait.until { @browser.button(name: 'btn_login').visible? }
      @browser.text_field(id: 'userEmail1').set(NEW_USER_EMAIL)
      @browser.button(name: 'btn_login').click

      # Create a new project  
      Watir::Wait.until { @browser.button(name: 'btn_logout').visible? }
      Watir::Wait.until { @browser.button(name: 'btn_create').visible? }
    
      @browser.button(name: 'btn_create').click
      Watir::Wait.until { @browser.input(name: 'projectName').visible? }
      @browser.text_field(name: 'projectName').set(NEW_PROJECT_NAME)
      @browser.text_field(name: 'dateStart').set(NEW_PROJECT_DATE_START)
      @browser.text_field(name: 'dateEnd').set(NEW_PROJECT_DATE_END)
      @browser.button(name: 'btn_next').click

      # Enter the project and set dailyplan

      Watir::Wait.until { @browser.button(name: 'btn_save').visible? }
      Watir::Wait.until { @browser.button(name: 'btn_find').visible? }
      @browser.text_field(name: 'location').set(DAY1_LOCATION)
      @browser.button(name: 'btn_find').click

      Watir::Wait.until { @browser.button(name: 'btn_choose0').visible? }
      Watir::Wait.until { @browser.button(name: 'btn_choose6').visible? }
      Watir::Wait.until { @browser.button(name: 'btn_choose12').visible? }
      Watir::Wait.until { @browser.button(name: 'btn_choose19').visible? }
      Watir::Wait.until { @browser.button(name: 'btn_back').visible? }

      @browser.button(name: 'btn_choose0').click
      Watir::Wait.until { @browser.input(name: 'origin').visible? }
      Watir::Wait.until { @browser.input(name: 'destination').visible? }
      Watir::Wait.until { @browser.input(name: 'start').visible? }
      Watir::Wait.until { @browser.input(name: 'end').visible? }
      @browser.text_field(name: 'origin').set(DAY1_ORIGIN)
      @browser.text_field(name: 'destination').set(DAY1_DESTINATION)
      @browser.text_field(name: 'start').set(DAY1_START)
      @browser.text_field(name: 'end').set(DAY1_END)
      @browser.button(name: 'btn_save').click

      @browser.button(name: 'btn_logout').click

      # Check if the dailyplan has been saved
      @browser.button(name: 'HaveAccount').click
      Watir::Wait.until { @browser.button(name: 'btn_login').visible? }
      @browser.text_field(id: 'userEmail1').set(NEW_USER_EMAIL)
      @browser.button(name: 'btn_login').click

      Watir::Wait.until { @browser.button(name: 'project_id').visible? }
      @browser.button(name: 'project_id').click

      Watir::Wait.until { @browser.input(name: 'origin').visible? }
      Watir::Wait.until { @browser.input(name: 'destination').visible? }
      Watir::Wait.until { @browser.input(name: 'start').visible? }
      Watir::Wait.until { @browser.input(name: 'end').visible? }
      @browser.text_field(name: 'origin').value.must_include DAY1_ORIGIN
      @browser.text_field(name: 'destination').value.must_include DAY1_DESTINATION
      @browser.text_field(name: 'start').value.must_include DAY1_START
      @browser.text_field(name: 'end').value.must_include DAY1_END
    end
  end
end

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

      
      Watir::Wait.until { @browser.button(name: 'btn_logout').visible? }
      
    end    
  end
end

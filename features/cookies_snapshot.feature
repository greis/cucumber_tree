Feature: Cookies Snapshot
  Scenario:
    Given I have created a new rails app
    And I write to "app/controllers/cookies_controller.rb" with:
      """
      class CookiesController < ApplicationController
        def index
          render text: cookies[:page]
        end

        def new
          cookies[:page] = 'new cookie'
          render nothing: true
        end
      end
      """
    And I write to "config/routes.rb" with:
      """
      TestApp::Application.routes.draw do
        resources :cookies
      end
      """
    And I write to "features/parent.feature" with:
      """
      Feature:
        Scenario:
          Given I go to the new cookie page
      """
    And I write to "features/parent/child.feature" with:
      """
      Feature:
        Scenario:
          When I go to the cookies display page
          Then I should see "new cookie"
      """
    And I write to "features/step_definitions/all_steps.rb" with:
      """
      When /^I go to the new cookie page$/ do
        visit '/cookies/new'
      end

      When /^I go to the cookies display page$/ do
        visit '/cookies'
      end

      Then /^I should see "(.*)"$/ do |content|
        page.should have_content(content)
      end
      """
    And I run `bundle exec rake db:migrate`

    When I run `bundle exec cucumber`
    Then it should pass with:
      """
      2 scenarios (2 passed)
      3 steps (3 passed)
      """

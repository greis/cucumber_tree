Feature: Current Url Snapshot
  Scenario:
    Given I have created a new rails app
    And I write to "app/controllers/users_controller.rb" with:
      """
      class UsersController < ApplicationController
        def index
          render text: 'Users Index'
        end
      end
      """
    And I write to "config/routes.rb" with:
      """
      TestApp::Application.routes.draw do
        resources :users
      end
      """
    And I write to "features/parent.feature" with:
      """
      Feature:
        Scenario:
          Given I go to the users page
      """
    And I write to "features/parent/child.feature" with:
      """
      Feature:
        Scenario:
          Then I should be on the users page
      """
    And I write to "features/another.feature" with:
      """
      Feature:
        Scenario:
          Given I go to the index page
      """
    And I write to "features/step_definitions/all_steps.rb" with:
      """
      When /^I go to the users page$/ do
        visit '/users'
      end

      When /^I go to the index page$/ do
        visit '/'
      end

      Then /^I should be on the users page$/ do
        page.current_path.should == '/users'
      end
      """
    And I run `bundle exec rake db:migrate`

    # Running only child feature
    When I run `bundle exec cucumber features/parent/child.feature`
    Then it should pass with:
      """
      2 scenarios (2 passed)
      2 steps (2 passed)
      """

    #Running entire suite test
    When I run `bundle exec cucumber`
    Then it should pass with:
      """
      3 scenarios (3 passed)
      3 steps (3 passed)
      """

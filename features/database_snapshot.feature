Feature: Database Snapshot
  Scenario:
    Given I have created a new rails app
    And I write to "features/parent.feature" with:
      """
      Feature:
        Scenario:
          Given 1 user
      """
    And I write to "features/parent/child.feature" with:
      """
      Feature:
        Scenario:
          Then 1 user should be created
      """
    And I write to "features/step_definitions/all_steps.rb" with:
      """
      When /^(\d+) users?$/ do |count|
        User.create
      end

      Then /^(\d+) users? should be created$/ do |count|
        User.count.should == count.to_i
      end
      """
    And I run `rails g model user`
    And I run `bundle exec rake db:migrate db:test:prepare`

    When I run `bundle exec cucumber`
    Then it should pass with:
      """
      2 scenarios (2 passed)
      2 steps (2 passed)
      """

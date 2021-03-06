Feature: Database Snapshot
  Scenario: Sqlite
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
    And I write to "features/z-last-feature-to-run.feature" with:
      """
      Feature:
        Scenario: Testing truncation
          Then 0 users should be created
      """
    And I run `rails g model user`
    And I run `bundle exec rake db:migrate db:test:prepare`

    When I run `bundle exec cucumber`
    Then it should pass with:
      """
      3 scenarios (3 passed)
      3 steps (3 passed)
      """

  Scenario: Postgresql
    Given I have created a new rails app with postgresql
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
    And I write to "features/z-last-feature-to-run.feature" with:
      """
      Feature:
        Scenario: Testing truncation
          Then 0 users should be created
      """
    And I run `rails g model user`
    And I run `bundle exec rake db:drop db:create db:migrate db:test:prepare`

    When I run `bundle exec cucumber`
    Then it should pass with:
      """
      3 scenarios (3 passed)
      3 steps (3 passed)
      """

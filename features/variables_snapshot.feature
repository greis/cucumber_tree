Feature: Variables Snapshot
  Scenario:
    Given I have created a new rails app
    And I write to "features/parent.feature" with:
      """
      Feature:
        Scenario:
          Given one user
      """
    And I write to "features/parent/child.feature" with:
      """
      Feature:
        Scenario:
          Then that user should be present
      """
    And I write to "features/step_definitions/all_steps.rb" with:
      """
      When /^one user$/ do
        @user = "Jack"
      end

      Then /^that user should be present$/ do
        @user.should == "Jack"
      end
      """
    And I run `bundle exec rake db:migrate db:test:prepare`

    When I run `bundle exec cucumber`
    Then it should pass with:
      """
      2 scenarios (2 passed)
      2 steps (2 passed)
      """

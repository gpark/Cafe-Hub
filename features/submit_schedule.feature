Feature: Submit preferred schedule and view it afterwards
  As an employer of ETS 
  So that I can let my boss know when I want to work
  I want to be able to submit my preferred schedule and view my submission
  
Background: user has been added to database
  
  Given the following users exists:
  | email                   | password      | password_confirmation      | name  |
  | isaac@james.com         | JamesJames    | JamesJames                 | Isaac |
  
  Scenario: submit a schedule
    Given I am on the login page
    When I fill in "Email" with "isaac@james.com"
    And I fill in "Password" with "JamesJames"
    And I press "Log in"
    Then I should be on the user dashboard
    When I follow "Create Preferred Schedule"
    Then I should be on the create preferred schedule page
    When I follow "Add Entry"
    And I select "Class" from "preference_type"
    And I check "M"
    And I check "W"
    And I select "2:00 PM" from "start_time"
    And I select "3:00 PM" from "end_ime"
    And I press "Submit Preference"
    Then I should be on the preferred schedules tab
    And I should see "Class" in the time slot for "2:00 PM" to "3:00 PM" on "Monday"
    And I should see "Class" in the time slot for "2:00 PM" to "3:00 PM" on "Wednesday"
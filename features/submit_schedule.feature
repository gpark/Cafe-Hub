Feature: Submit preferred schedule and view it afterwards
  As an employer of ETS 
  So that I can let my boss know when I want to work
  I want to be able to submit my preferred schedule and view my submission
  
  Scenario: submit a schedule
    Given Isaac's account is set up
    And I am logged in as Isaac
    And I am on Isaac's user home page
    And I follow "Create Preferred Schedule"
    Then I should be on the create preferred schedule page
    When I follow "Add Entry"
    And I select "Class" from "Entry Type"
    And I check "M"
    And I check "W"
    And I select "2:00 PM" from "Start Time"
    And I select "3:00 PM" from "End Time"
    And I press "Submit"
    Then I should be on the preferred schedules tab
    And I should see "Class" in the time slot for "2:00 PM" to "3:00 PM" on "Monday"
    And I should see "Class" in the time slot for "2:00 PM" to "3:00 PM" on "Wednesday"

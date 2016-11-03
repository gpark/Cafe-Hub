Feature: Only admins can set user schedules.
  As an admin
  In order to maintain consistency within schedules
  Only I should be able to assign users to man certain facilities at certain times
  
Background: admin and non-admin user accounts exist
  Given the admin code is "1234"
  And there is an admin account
  And the following users exists:
  | email                   | password      | password_confirmation      | name  |
  | isaac@james.com         | JamesJames    | JamesJames                 | Isaac |
  
  Scenario: admin user should see link to set schedule
    Given I am logged in as "Admin"
    And I am on the home page
    When I follow "Assign user schedules"
    Then I should be on the generate assignments page
    
  Scenario: non-admin user should not be able to access set schedule page
    Given I am logged in as "Isaac"
    And I am on the user dashboard page
    Then I should not see "Assign user schedules"
    When I am on the generate assignments page
    Then I should see an alert message saying "You are not authorized to access this page"
    
Feature: admin can make other users admins
  As an admin
  In order to control privileges and delegate responsibility
  I want to give admin access to other users
  
Background: admin and non-admin user accounts exist
  Given the admin code is "1234"
  And there is an admin account
  And the following users exists:
  | email                   | password      | password_confirmation      | name  |
  | isaac@james.com         | JamesJames    | JamesJames                 | Isaac |
  
  Scenario: giving another user admin privileges
    Given I am logged in as "Admin"
    When I am on the all users page
    Then I should see "Isaac"
    When I check the checkbox next to "Isaac"
    And I fill in "confirm" with "1234"
    And I press "Make Admin"
    Then I should see an alert message saying "Admins updated"
    And I should be on the all users page
    And I should see admin tag next to "Isaac"
    When I log out
    And I am logged in as "Isaac"
    And I try to go to the settings page
    Then I should not see any alert message
    And I should see "Sign-up Code"
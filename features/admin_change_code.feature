Feature: Only admins can change the sign up code
  As an admin
  In order to make sure only users approved by me sign up
  Only I should be able to change the sign up code
  
Background: admin and non-admin user accounts exist
  Given the admin code is "1234"
  And there is an admin account
  And the following users exists:
  | email                   | password      | password_confirmation      | name  |
  | isaac@james.com         | JamesJames    | JamesJames                 | Isaac |

  Scenario: non-admin user should not be able to access settings page
    Given I am logged in as "Isaac"
    When I am on the settings page
    Then I should see an alert message saying "You are not authorized to access this page"
    
  Scenario: admin can change sign up code
    Given I am logged in as "Admin"
    When I am on the settings page
    And I fill in "Sign up code" with "1111"
    And I press "Update"
    Then I should see an alert message saying "Setting has updated"
    And the admin code should be "1111"
  
  
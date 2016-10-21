Feature: Login a user with username and password
  As a user of ETS scheduler
  So that I can submit preferred schedule times and view my schedule
  I want to be able to login to the website

Background: user has been added to database
  
  Given the following users exists:
  | email                   | password      | password_confirmation      | name  |
  | isaac@james.com         | JamesJames    | JamesJames                 | Isaac |

  Scenario: login a user
    Given I am on the login page
    When I fill in "Email" with "isaac@james.com"
    And I fill in "Password" with "JamesJames"
    And I press "Log in"
    Then I should see "Signed in successfully."
    And I should be on the user dashboard

Background: user has been added to database
  
  Given the following users exists:
  | email                   | password | name  |
  | isaac@james.com         | James    | Isaac |

Feature: Login a user with username and password
  As a user of ETS scheduler
  So that I can submit preferred schedule times and view my schedule
  I want to be able to login to the website

  Scenario: login a user
    Given I am on the login page
    When I fill in "email" with "isaac@james.com" 
    And I fill in "password" with "James"
    And I press "submit"
    Then I should be on the home page
    And I should see "Welcome, Isaac"
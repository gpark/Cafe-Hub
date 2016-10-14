Feature: Login a user with username and password
  As a user of ETS scheduler
  So that I can submit preferred schedule times and view my schedule
  I want to be able to login to the website

  Scenario: login a user
    Given I am on the login page
    And Isaac's account is set up
    When I fill in "email" with "isaac@james.com" 
    And I fill in "password" with "James"
    And I press "submit"
    Then I should be on Isaac's user home page
    And I should see "Welcome, Isaac"
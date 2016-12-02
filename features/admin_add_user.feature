Feature: Signing up requires code from admin.
  As an admin
  In order to ensure that only ETS employees can create accounts
  I want to issue sign up codes and require them for creating accounts
  
Background: sign up code should be set
  Given the admin code is "1234"
  
  Scenario: sign ups without code shouldn't work
    Given I am on the sign up page
    When I fill in "Name" with "Isaac"
    And I fill in "Email" with "isaac@james.com"
    And I fill in "Password" with "JamesJames"
    And I fill in "Password confirmation" with "JamesJames"
    And I press "Sign up"
    Then I should see "Sign up code is incorrect"
    And I should be on the sign up post page
  
  Scenario: sign ups with code are allowed
    Given I am on the sign up page
    When I fill in "Name" with "Isaac"
    And I fill in "Email" with "isaac@james.com"
    And I fill in "Password" with "JamesJames"
    And I fill in "Password confirmation" with "JamesJames"
    And I fill in "Sign up code" with "1234"
    And I press "Sign up"
    Then I should see "Welcome! You have signed up successfully"
    And I should be on the home page
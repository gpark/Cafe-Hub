Feature: Users can view other users' preferred schedules.
  As a user
  In order to see people's availabilities
  I should be able to see other users' preferred schedules
  
Background: user has preferred schedule set
    
  Given the following users exists:
  | email                   | password      | password_confirmation      | name  |
  | isaac@james.com         | JamesJames    | JamesJames                 | Isaac |
  | james@james.com         | NotJames      | NotJames                   | James |
  
  And "Isaac" has preferences:
  | type     | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time | 
  | Prefer   | false | true  | false | true  | false | false | false | 3:30 PM    | 5:30 PM  |
  | Class    | false | false | true  | false | true  | false | false | 9:30 AM    | 11:00 AM |
  
  Scenario: user should be able to see other user's schedules
    Given I am logged in as "James"
    And I am on the all users page
    When I follow "Isaac"
    Then I should see "Class" in the time slot for "9:30 AM" to "11:00 AM" on "Tuesday"
    And I should see "Class" in the time slot for "9:30 AM" to "11:00 AM" on "Thursday"
    And I should see "Prefer" in the time slot for "3:30 PM" to "5:30 PM" on "Monday"
    And I should see "Prefer" in the time slot for "3:30 PM" to "5:30 PM" on "Wednesday"
    
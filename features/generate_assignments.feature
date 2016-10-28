Feature: Admin can gereate assignments to employees
  As an admin
  I would like to be able to generate assignments to my employees
  
Background: We have one user with limited availabilities and an admin
  Given there is an admin account
  And I am logged in as "admin"
  And the following users exists:
  | email                   | password      | password_confirmation      | name  |
  | isaac@james.com         | JamesJames    | JamesJames                 | Isaac |
  
  And "Isaac" has preferences:
  | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time | 
  | Prefer     | false | true  | false | true  | false | false | false | 12:30 PM   | 5:30 PM  |
  | Class      | false | true  | false | true  | false | false | false | 7:30 AM    | 12:30 PM |
  | Class      | false | true  | false | true  | false | false | false | 5:30 PM    | 11:30 PM |
  | Obligation | false | false | true  | false | true  | true  | false | 7:30 AM    | 11:30 PM |
  
  And the following facilities exists:
  | name | su_start | su_end | m_start | m_end   | tu_start | tu_end  | w_start | w_end   | th_start | th_end  | f_start | f_end    | sa_start | sa_end | ppl_per_shift |
  | MMF  | null     | null   | 8:00 AM | 2:00 AM | 8:00 AM  | 2:00 AM | 8:00 AM | 2:00 AM | 8:00 AM  | 2:00 AM | 8:00 AM | 10:00 PM | null     | null   | 1             |
  
  Scenario: Admin should be able to generate schedules based on user preferences and facility times
    Given I am on the generate assignments page
    Then I should see "Isaac"
    When I press "Generate Schedule"
    Then I should be on the all facilities page
    When I follow "MMF"
    Then I should see "Isaac" assigned to shift "12:30 PM" to "5:30 PM" on "Monday"
    And I should see "Isaac" assigned to shift "12:30 PM" to "5:30 PM" on "Wednesday"
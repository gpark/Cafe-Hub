Feature: Submit substitute request and have someone else take it
  As an employer of ETS 
  So that I can get someone else to work for me in case of a schedule conflict
  I want to be able to submit a request for someone to work during my shift
  
Background: Users exist
   Given the following users exists:
   | email                   | password      | password_confirmation      | name  | id |
   | isaac@zhang.com         | JamesJames    | JamesJames                 | Isaac | 2  |
   | james@lee.com           | NotJames      | NotJames                   | James | 3  |
    Given the following facilities exists:
    | name | su_start | su_end | m_start | m_end   | tu_start | tu_end  | w_start | w_end   | th_start | th_end  | f_start | f_end    | sa_start | sa_end | ppl_per_shift | id |
    | MMF  | null     | null   | 8:00 AM | 2:00 AM | 8:00 AM  | 2:00 AM | 8:00 AM | 2:00 AM | 8:00 AM  | 2:00 AM | 8:00 AM | 10:00 PM | null     | null   | 1             | 1  |
    And the following assignments week exists:
    | start_date | end_date   | id |
    | 2016-10-31 | 2016-11-06 | 1  |
    And the following assignments exists:
    | user_id | facility_id | assignments_week_id | start_time | end_time | day |
    |    2    |      1      |        1            |   8:00 AM  |  9:00 AM | m   |
    
Scenario: submit a substitute request
  Given I am logged in as "Isaac"
  Given I am on the request substitute page
  And I select "MMF: M 8:00 AM - 9:00 AM" from "sub_assignment_id"
  And I press "Submit"
  Then I should be on the all substitutes page
  And I should see "MMF-Isaac" in the time slot for "08:00 AM - 09:00 AM" on "Monday"
  
Scenario: take someones substitute request
  Given I am logged in as "Isaac"
  Given I am on the request substitute page
  And I select "MMF: M 8:00 AM - 9:00 AM" from "sub_assignment_id"
  And I press "Submit"
  Then I should be on the all substitutes page
  Given I log out
  And I am logged in as "James"
  When I am on the all substitutes page
  And I press "Take Shift"
  Then I should be on the dashboard
  And I should see "MMF" in the time slot for "08:00 AM - 09:00 AM" on "Monday"
  When I am on the all substitutes page
  Then I should not see "MMF-Isaac" in the time slot for "08:00 AM - 09:00 AM" on "Monday"
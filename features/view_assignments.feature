Feature: Need to be able to view my own and others' assigned schedules
  
  Background: There are users with assignments_week_id
    Given the following users exists:
    | email                   | password      | password_confirmation      | name  | id |
    | isaac@zhang.com         | ZhangZhang    | ZhangZhang                 | Isaac | 2  |
    | james@lee.com           | LeeLee        | LeeLee                     | James | 3  |
    And I am logged in as "Isaac"
    Given the following facilities exists:
    | name | su_start | su_end | m_start | m_end   | tu_start | tu_end  | w_start | w_end   | th_start | th_end  | f_start | f_end    | sa_start | sa_end | ppl_per_shift | id |
    | MMF  | null     | null   | 8:00 AM | 2:00 AM | 8:00 AM  | 2:00 AM | 8:00 AM | 2:00 AM | 8:00 AM  | 2:00 AM | 8:00 AM | 10:00 PM | null     | null   | 1             | 1  |
    And the following assignments week exists:
    | start_date | end_date   | id |
    | 2016-10-31 | 2016-11-06 | 1  |
    And the following assignments exists:
    | user_id | facility_id | assignments_week_id | start_time | end_time | su    | m     | tu    | w     | th    | f     | sa    |
    |    2    |      1      |        1            |   8:00 AM  |  9:00 AM | false | true  | false | true  | false | false | false |
    |    3    |      1      |        1            |  3:00 PM   | 5:00 PM  | false | false | true  | false | false | false | false |
   
  Scenario: View my own schedule
    When I am on the user dashboard
    Then I should see "MMF" in the time slot for "08:00 AM - 09:00 AM" on "Monday"
    And I should see "MMF" in the time slot for "08:00 AM - 09:00 AM" on "Wednesday"

  Scenario: View other's schedule
    When I am on James' assigned schedule page
    Then I should see "MMF" in the time slot for "03:00 PM - 05:00 PM" on "Tuesday"
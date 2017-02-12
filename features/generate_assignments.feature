Feature: Admin can gereate assignments to employees
  As an admin
  I would like to be able to generate assignments to my employees

Background: We have one user with limited availabilities and an admin
  Given there is an admin account
  And I am logged in as "Admin"
  And the following users exists:
  | email                   | password      | password_confirmation      | name  |
  | xx@cafe-hub.com         | xxxxxx        | xxxxxx                     | XX    |
  | isaac@james.com         | JamesJames    | JamesJames                 | Isaac |
  And the following assignments week exists:
  | start_date | end_date   |
  | 2016-10-31 | 2016-11-06 |

  Scenario: Admin should be able to generate schedules based on user preferences and facility times
    Given the following facilities exists:
    | name | m_start | m_end    | tu_start | tu_end   | w_start | w_end    | th_start | th_end   | f_start | f_end    | ppl_per_shift |
    | MMF  | 8:00 AM | 11:00 PM | 8:00 AM  | 11:00 PM | 8:00 AM | 11:00 PM | 8:00 AM  | 11:00 PM | 8:00 AM | 10:00 PM | 1             |
    And "Isaac" has preferences:
    | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
    | Prefer     | false | true  | false | true  | false | false | false | 12:00 PM   | 5:00 PM  |
    | Class      | false | true  | false | true  | false | false | false | 7:00 AM    | 12:00 PM |
    | Class      | false | true  | false | true  | false | false | false | 5:00 PM    | 11:00 PM |
    | Obligation | false | false | true  | false | true  | true  | false | 7:00 AM    | 11:00 PM |
    And I am on the first assignments week page
    When I follow "Automatically Generate Assignments"
    Then I should be on the first assignments week page
    When I follow "MMF"
    Then I should see "Isaac" in the time slot for "12:00 PM - 01:00 PM" on "Monday"
    And I should see "Isaac" in the time slot for "01:00 PM - 02:00 PM" on "Monday"
    And I should see "Isaac" in the time slot for "02:00 PM - 03:00 PM" on "Monday"
    And I should see "Isaac" in the time slot for "03:00 PM - 04:00 PM" on "Monday"
    And I should see "Isaac" in the time slot for "04:00 PM - 05:00 PM" on "Monday"
    And I should see "Isaac" in the time slot for "12:00 PM - 01:00 PM" on "Wednesday"
    And I should see "Isaac" in the time slot for "04:00 PM - 05:00 PM" on "Wednesday"

    Scenario: Algorithm should handle closing times after midnight
      Given the following facilities exists:
      | name | m_start | m_end    | tu_start | tu_end  | w_start | w_end    | th_start | th_end  | f_start | f_end    | ppl_per_shift |
      | MMF  | 8:00 AM | 2:00 AM  | 8:00 AM  | 2:00 AM | 8:00 AM | 2:00 AM  | 8:00 AM  | 2:00 AM | 8:00 AM | 10:00 PM | 1             |
      And "Isaac" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | Prefer     | false | true  | false | true  | false | false | false | 12:00 PM   | 5:00 PM  |
      | Class      | false | true  | false | true  | false | false | false | 7:00 AM    | 12:00 PM |
      | Class      | false | true  | false | true  | false | false | false | 5:00 PM    | 11:00 PM |
      | Obligation | false | false | true  | false | true  | true  | false | 7:00 AM    | 11:00 PM |
      | Obligation | false | true  | true  | true  | true  | true  | false | 11:00 PM   | 2:00 AM  |
      And I am on the first assignments week page
      When I follow "Automatically Generate Assignments"
      Then I should be on the first assignments week page
      When I follow "MMF"
      Then I should see "Isaac" in the time slot for "12:00 PM - 01:00 PM" on "Monday"
      And I should see "Isaac" in the time slot for "01:00 PM - 02:00 PM" on "Monday"
      And I should see "Isaac" in the time slot for "02:00 PM - 03:00 PM" on "Monday"
      And I should see "Isaac" in the time slot for "03:00 PM - 04:00 PM" on "Monday"
      And I should see "Isaac" in the time slot for "04:00 PM - 05:00 PM" on "Monday"
      And I should see "Isaac" in the time slot for "12:00 PM - 01:00 PM" on "Wednesday"
      And I should see "Isaac" in the time slot for "04:00 PM - 05:00 PM" on "Wednesday"

    Scenario: R/N work should still allow assignments when there's nobody else to fill those  spots
      Given the following facilities exists:
      | name | m_start | m_end    | tu_start | tu_end  | w_start | w_end    | th_start | th_end  | f_start | f_end    | ppl_per_shift |
      | MMF  | 8:00 AM | 11:00 PM | 8:00 AM  | 2:00 AM | 8:00 AM | 11:00 PM | 8:00 AM  | 2:00 AM | 8:00 AM | 10:00 PM | 1             |
      And "Isaac" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | R/N Work   | true  | true  | true  | true  | true  | true  | true  | 12:00 AM   | 12:00 AM |
      And I am on the first assignments week page
      When I follow "Automatically Generate Assignments"
      Then I should be on the first assignments week page
      When I follow "MMF"
      Then I should see "Isaac"

    Scenario: Algorithm should assume no preference still means available
      Given the following facilities exists:
      | name | m_start | m_end    | tu_start | tu_end  | w_start | w_end    | th_start | th_end  | f_start | f_end    | ppl_per_shift |
      | MMF  | 8:00 AM | 1:00 PM  | 8:00 AM  | 1:00 PM | 8:00 AM | 1:00 PM  | 8:00 AM  | 1:00 PM | 8:00 AM | 1:00 PM  | 1             |
      And "Isaac" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | Class      | false | true  | false | true  | false | false | false | 7:00 AM    | 12:00 PM |
      | Class      | false | true  | false | true  | false | false | false | 5:00 PM    | 11:00 PM |
      | Obligation | false | false | true  | false | true  | true  | false | 7:00 AM    | 11:00 PM |
      And I am on the first assignments week page
      When I follow "Automatically Generate Assignments"
      Then I should be on the first assignments week page
      When I follow "MMF"
      And I should see "Isaac" in the time slot for "12:00 PM - 01:00 PM" on "Monday"
      And I should see "Isaac" in the time slot for "12:00 PM - 01:00 PM" on "Wednesday"
      And I should not see "Isaac" in the time slot for "11:00 AM - 12:00 PM" on "Monday"
      And I should not see "Isaac" in the time slot for "11:00 AM - 12:00 PM" on "Wednesday"

    Scenario: Assignments should be in larger chunks of time
      Given the following facilities exists:
      | name | m_start | m_end    | tu_start | tu_end  | w_start | w_end    | th_start | th_end  | f_start | f_end    | ppl_per_shift |
      | MMF  | 8:00 AM | 1:00 PM  | 8:00 AM  | 1:00 PM | 8:00 AM | 1:00 PM  | 8:00 AM  | 1:00 PM | 8:00 AM | 1:00 PM  | 1             |
      And the following users exists:
      | email                   | password      | password_confirmation      | name   |
      | grace@park.com          | GraceGrace    | GraceGrace                 | Grace  |
      | nancy@pham.com          | FancyNancy    | FancyNancy                 | Nancy  |
      | aaron@ching.com         | ka-ching      | ka-ching                   | Aaron  |
      | james@james.com         | JamesJames    | JamesJames                 | James  |
      | victor@lu.com           | victorlu      | victorlu                   | Victor |
      And "Isaac" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time  |
      | Class      | false | true  | false | true  | false | true  | false | 7:00 AM    |  1:00 PM  |
      | Prefer     | false | false | true  | false | true  | false | false | 7:00 AM    |  11:00 AM |
      And "Nancy" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | Prefer     | false | true  | true  | true  | true  | true  | false | 9:00 AM    |  2:00 PM |
      And "Aaron" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | Prefer     | false | true  | true  | true  | true  | true  | false | 9:00 AM    |  2:00 PM |
      And "James" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | Prefer     | false | true  | true  | true  | true  | true  | false | 9:00 AM    |  2:00 PM |
      And "Victor" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | Prefer     | false | true  | true  | true  | true  | true  | false | 9:00 AM    |  2:00 PM |
      And "Grace" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | Prefer     | false | true  | true  | true  | true  | true  | false | 9:00 AM    |  2:00 PM |
      And I am on the first assignments week page
      When I follow "Automatically Generate Assignments"
      Then I should be on the first assignments week page
      When I follow "MMF"
      And I should see "Isaac" in the time slot for "08:00 AM - 09:00 AM" on "Tuesday"
      And I should see "Isaac" in the time slot for "09:00 AM - 10:00 AM" on "Tuesday"
      And I should not see "Grace" in the time slot for "08:00 AM - 09:00 AM" on "Tuesday"
      And I should not see "Grace" in the time slot for "09:00 AM - 10:00 AM" on "Tuesday"

    Scenario: User XX assigned when nobody available
      Given the following facilities exists:
      | name | m_start | m_end    | tu_start | tu_end  | w_start | w_end    | th_start | th_end  | f_start | f_end    | ppl_per_shift |
      | MMF  | 8:00 AM | 1:00 PM  | 8:00 AM  | 1:00 PM | 8:00 AM | 1:00 PM  | 8:00 AM  | 1:00 PM | 8:00 AM | 1:00 PM  | 1             |
      And "Isaac" has preferences:
      | type       | su    | m     | tu    | w     | th    | f     | sa    | start_time | end_time |
      | Class      | false | true  | false | true  | false | false | false | 7:00 AM    | 12:00 PM |
      | Class      | false | true  | false | true  | false | false | false | 5:00 PM    | 11:00 PM |
      | Obligation | false | false | true  | false | true  | true  | false | 7:00 AM    | 11:00 PM |
      And I am on the first assignments week page
      When I follow "Automatically Generate Assignments"
      Then I should be on the first assignments week page
      When I follow "MMF"
      And I should see "Isaac" in the time slot for "12:00 PM - 01:00 PM" on "Monday"
      And I should see "Isaac" in the time slot for "12:00 PM - 01:00 PM" on "Wednesday"
      And I should see "XX" in the time slot for "11:00 AM - 12:00 PM" on "Monday"
      And I should see "XX" in the time slot for "11:00 AM - 12:00 PM" on "Wednesday"    

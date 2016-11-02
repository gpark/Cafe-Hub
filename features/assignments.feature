Feature: Submit information for schedule generating
  As an admin, I'd like to be able to submit new weeks to generate schedules for
  As well as facilities for assignments to be made towards
  I'd also like to be able to manually make assignments
  
 Background: Users exist
   Given there is an admin account
   And I am logged in as "Admin"
   And the following users exists:
   | email                   | password      | password_confirmation      | name  |
   | isaac@zhang.com         | ZhangZhang    | ZhangZhang                 | Isaac |
   | james@lee.com           | LeeLee        | LeeLee                     | James |
   
   Scenario: Create new week
     Given I am on the new assignments week page
     Then I should see "Create New Week"
     When I select "2016" from "assignments_week_start_date_1i"
     And I select "October" from "assignments_week_start_date_2i"
     And I select "31" from "assignments_week_start_date_3i"
     And I select "2016" from "assignments_week_end_date_1i"
     And I select "November" from "assignments_week_end_date_2i"
     And I select "6" from "assignments_week_end_date_3i"
     And I press "Create"
     Then I should be on the first assignments week page
     And I should see "Week created"
     And I should see "Week of 2016-10-31 to 2016-11-06"
     
  Scenario: Create new facility
    Given I am on the new facility page
    Then I should see "Create New Facility"
    When I fill in "facility_name" with "MMF"
    And I select "2" from "facility_ppl_per_shift"
    And I select "8:00 AM" from "M Start Time"
    And I select "8:00 AM" from "Tu Start Time"
    And I select "8:00 AM" from "W Start Time"
    And I select "9:00 AM" from "Th Start Time"
    And I select "10:00 AM" from "F Start Time"
    And I select "12:00 AM" from "M End Time"
    And I select "12:00 AM" from "Tu End Time"
    And I select "12:00 AM" from "W End Time"
    And I select "10:00 PM" from "Th End Time"
    And I select "9:00 PM" from "F End Time"
    And I press "Create"
    Then I should see "Facility created"
    And I should see "8:00 AM"
    And I should not see "7:00 AM"
    And I should see "11:00 PM"
    And I should not see "3:00 AM"
    
  Scenario: Manually assign a shift
    Given the following facilities exists:
    | name | su_start | su_end | m_start | m_end   | tu_start | tu_end  | w_start | w_end   | th_start | th_end  | f_start | f_end    | sa_start | sa_end | ppl_per_shift |
    | MMF  | null     | null   | 8:00 AM | 2:00 AM | 8:00 AM  | 2:00 AM | 8:00 AM | 2:00 AM | 8:00 AM  | 2:00 AM | 8:00 AM | 10:00 PM | null     | null   | 1             |
    And the following assignments week exists:
    | start_date | end_date   |
    | 2016-10-31 | 2016-11-06 |
    Given I am on the new assignment page
    Then I should see "Create New Assignment"
    When I select "Isaac" from "assignment_user_id"
    And I check "M"
    And I select "3:00 PM" from "Start Time"
    And I select "5:00 PM" from "Start Time"
    And I press "Create"
    Then I should see "MMF"
    And I should see "Isaac" assigned to shift "03:00 PM - 04:00 PM" on "Monday"
    And I should see "Isaac" assigned to shift "04:00 PM - 05:00 PM" on "Monday"
    When I am on the new assignment page
    When I select "James" from "assignment_user_id"
    And I check "M"
    And I select "4:00 PM" from "Start Time"
    And I select "6:00 PM" from "Start Time"    
    And I press "Create"
    Then I should see "MMF"
    And I should see "Isaac, James" assigned to shift "04:00 PM - 05:00 PM" on "Monday"
    And I should see "James" assigned to shift "05:00 PM - 06:00 PM" on "Monday"
    
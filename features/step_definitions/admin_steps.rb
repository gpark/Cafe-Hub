Given /^the admin code is "([0-9]+)"/ do |code|
    pending
end

Given(/^there is an admin account$/) do
  User.create!({:email => 'admin@cafe-hub.com', :password => 'aadmin', :password_confirmation => 'aadmin', :name => 'Admin'})
end

Given(/^the following facilities exists:$/) do |facilities_table|
  facilities_table.hashes.each do |f|
    Facility.create!(f)
  end
end

Given(/^the following assignments week exists:$/) do |aw_table|
  aw_table.hashes.each do |aw|
    AssignmentsWeek.create!(aw)
  end
end

Given(/^the following assignments exists:$/) do |a_table|
  a_table.hashes.each do |a|
    a_hash = {"user_id" => a["user_id"], "facility_id" => a["facility_id"], "assignments_week_id" => a["assignments_week_id"]}
    a.delete("user_id")
    a.delete("facility_id")
    a.delete("assignments_week_id")
    assn = Assignment.create!(a_hash)
    assn.occurences.create!(a)
  end
end

Then(/^I should see "([^"]*)" assigned to shift "([^"]*)" on "([^"]*)"$/) do |employee, times, day|
  day_conversions = {"Monday" => "m", "Tuesday"=>"tu", "Wednesday"=>"w", "Thursday"=>"th", "Friday"=>"f", "Saturday"=>"sa", "Sunday"=>"su"}
  converted_day = day_conversions[day]
  expected_id = converted_day + "_" + times
  within("//td[@id^='" + expected_id + "']") do
    page.should have_content(employee)
  end
end
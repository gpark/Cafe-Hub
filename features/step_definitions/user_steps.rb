Given /the following users exists/ do |users_table|
    users_table.hashes.each do |user|
        User.create!(user)
    end
end

Given /^I am logged in as "([^"]*)"/ do |user|
    pending
end

Given /^"([^"]*)" has preferences/ do |preferences_table|
    pending
end

Then /^I should see "([^"]*)" in the time slot for "([^"]*)" to "([^"]*)" on "([^"]*)"$/ do |entry_name, start_time, end_time, day|
  mapping = {"Monday" => "day wday-1 past current-month", 
             "Tuesday" => "day wday-2 past current-month", 
             "Wednesday" => "day wday-3 past current-month",
             "Thursday" => "day wday-4 past current-month",
             "Friday" => "day wday-5 past current-month",
             "Saturday"=>"day wday-6 past current-month",
             "Sunday" => "day wday-0 past current-month"}
  within("//td[@class='" + mapping[day.to_s] + "']") do 
      page.should have_content(entry_name)
      page.should have_content(start_time)
      page.should have_content(end_time)
  end
end












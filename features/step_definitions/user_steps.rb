Given /the following users exists/ do |users_table|
    users_table.hashes.each do |user|
        User.create!(user)
    end
end

Given /^I am logged in as "([^"]*)"/ do |user|
    pending
end

Given /^"([^"]*)" has preferences/ do |user, preferences_table|
    pending
end

Then /^I should see "([^"]*)" in the time slot for "([^"]*)" to "([^"]*)" on "([^"]*)"$/ do |entry_name, start_time, end_time, day|
  mapping = {"Monday" => "day wday-1", 
             "Tuesday" => "day wday-2", 
             "Wednesday" => "day wday-3",
             "Thursday" => "day wday-4",
             "Friday" => "day wday-5",
             "Saturday"=>"day wday-6",
             "Sunday" => "day wday-0"}
  within("//td[@class^='" + mapping[day.to_s] + "']") do 
      page.should have_content(entry_name)
      page.should have_content(start_time)
      page.should have_content(end_time)
  end
end












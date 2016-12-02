Given /the following users exists/ do |users_table|
    users_table.hashes.each do |user|
        user[:sign_up_code] = Setting.sign_up_code
        User.create!(user)
    end
end

Given /I log out/ do
   click_link("Logout")
end

Given /^I am logged in as "([^"]*)"/ do |user|
    
    user = User.where("name='"+user+"'")[0]
    visit '/users/sign_in'
    fill_in "user_email", :with => user.email

    passwords = {"Admin" => "aadmin", "James" => "NotJames", "Isaac" => "JamesJames"}
    password = passwords[user.name]
    if password == nil
        password = ""
    end
    fill_in "user_password", :with => password
    click_button "Log in"
end

Given /^"([^"]*)" has preferences/ do |user, preferences_table|
    user = User.where("name='"+user+"'")[0]
    p = user.preferences.create!
    preferences_table.hashes.each do |preference_entry|
        entry = p.preference_entries.new({:preference_type => preference_entry["type"]})
        preference_entry.delete("type")
        occurence = entry.occurences.new(preference_entry)
        occurence.save
        entry.save
    end
end

Then(/^I should see "([^"]*)" in the time slot for "([^"]*)" on "([^"]*)"$/) do |employee, times, day|
  day_conversions = {"Monday" => "m", "Tuesday"=>"tu", "Wednesday"=>"w", "Thursday"=>"th", "Friday"=>"f", "Saturday"=>"sa", "Sunday"=>"su"}
  converted_day = day_conversions[day]
  expected_id = converted_day + "_" + times
  within("//td[@id^='" + expected_id + "']") do
    page.should have_content(employee)
  end
end

Then(/^I should not see "([^"]*)" in the time slot for "([^"]*)" on "([^"]*)"$/) do |employee, times, day|
  day_conversions = {"Monday" => "m", "Tuesday"=>"tu", "Wednesday"=>"w", "Thursday"=>"th", "Friday"=>"f", "Saturday"=>"sa", "Sunday"=>"su"}
  converted_day = day_conversions[day]
  expected_id = converted_day + "_" + times
  within("//td[@id^='" + expected_id + "']") do
    page.should_not have_content(employee)
  end
end

Then /^I should see an alert message saying "([^"]*)"$/ do |message|
    page.should have_selector ".alert", text: message
end

Then(/^I should not see any alert message$/) do
  page.should_not have_selector ".alert"
end

Given(/^I select the first assignment from the dropdown$/) do
  pending
end







Given /the following user exists/ do |users_table|
    user_table.hashes.each do |user|
        User.create(user)
    end
end

# Given /^I am on the login page$/ do 
#     redirect_to "/users/sign_in"
# end



Given /^I am logged in as Isaac$/ do
    pending
end

Then /^I should see "([^"]*)" in the time slot for "([^"]*)" to "([^"]*)" on "([^"]*)"$/ do |entry_name, start_time, end_time, day|
  pending
end


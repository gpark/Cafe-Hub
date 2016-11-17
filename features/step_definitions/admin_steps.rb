Given /^the admin code is "([0-9]+)"/ do |code|
  Setting.sign_up_code = code
end

Given /^there is an admin account$/ do
  User.create!({:email => 'admin@cafe-hub.com', :password => 'aadmin', :password_confirmation => 'aadmin', :name => 'Admin', :admin => true, :sign_up_code => Setting.sign_up_code})
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

Then /^the admin code should be "([0-9]+)"$/ do |code|
  expect(Setting.sign_up_code == code)
end

Given(/^the following assignments exists:$/) do |a_table|
  a_table.hashes.each do |a|
    Assignment.create!(a)
  end
end

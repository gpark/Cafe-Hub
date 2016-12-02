# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
      
    when /^the user dashboard$/
      '/'
      
    when /^the dashboard$/
      '/dashboard'      
      
    when /^the login page$/
      '/users/sign_in'  
    
    when /^the sign up page$/
      '/users/sign_up'
      
    when /^the sign up post page$/
      '/users'
      
    when /the create preferred schedule page$/
      '/dashboard/new_preference'
      
    when /the preferred schedules tab$/
      '/dashboard/preferences'
      
    when /the first assignments week page$/
      '/assignments_weeks.1'
      
    when /the new assignments week page$/
      '/assignments_weeks/new'
      
    when /the new facility page$/
      '/facilities/new'
      
    when /the new assignment page$/
      '/assignments/new'
    
    when /the show assignments page$/
      '/assignments_weeks'
      
    when /the settings page/
      '/settings'
      
    when /the first facility page$/
      '/facilities.1'
      
    when /the all users page$/
      '/users/all'
      
    when /Isaac's assigned schedule page$/
      '/users/2'
      
    when /James' assigned schedule page$/
      '/users/3'

    when /the request substitute page$/
      '/subs/new'
      
    when /the all substitutes page$/
      '/subs'
      
    when /Isaac's delete assignments page$/
      '/users/2/delete_assignments'
      
    else
      # probably need this at some point
      # begin
      #   page_name =~ /^the (.*) page$/
      #   path_components = $1.split(/\s+/)
      #   self.send(path_components.push('path').join('_').to_sym)
      # rescue NoMethodError, ArgumentError
      #   raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      #     "Now, go and add a mapping in #{__FILE__}"
      # end
    end
  end
end

World(NavigationHelpers)

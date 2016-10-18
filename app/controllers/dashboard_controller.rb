class DashboardController < ApplicationController
    def create_preference
        @preference = current_user.preferences.new
        @preference_entry = @preference.preference_entries.new
        @entry_occurence = @preference_entry.entry_occurences.new
        if @preference.save
            redirect_to '/dashboard', alert: "Preference submitted successfully."
        else
            redirect_to '/dashboard/new_preference', alert: "Error creating preference."
        end
    end
    
    def new_preference
        @preference = current_user.preferences.new
        @preference_entry = @preference.preference_entries.new
        @entry_occurence = @preference_entry.entry_occurences.new
        render 'new_preference'
    end
end
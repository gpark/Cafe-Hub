class DashboardController < ApplicationController
    def create_preference
        pref = current_user.preferences.new(preference_params)
        # @preference = current_user.preferences.new
        # @preference_entry = @preference.preference_entries.new
        # @entry_occurence = @preference_entry.entry_occurences.new
        if pref.save
            redirect_to '/dashboard/preferences', notice: "Preference submitted successfully."
        else
            redirect_to '/dashboard/new_preference', alert: "Error creating preference."
        end
    end
    
    def new_preference
        @preference = current_user.preferences.new
        @preference_entry = @preference.preference_entries.new
        @entry_occurence = @preference_entry.entry_occurences.new
        times = Array.new(24.hours / 30.minutes) {|i| [(Time.now.midnight + (i*30.minutes)).strftime("%I:%M %p"), (Time.now.midnight + (i*30.minutes)).strftime("%I:%M %p")]}
        @start_times = ["Select Start Time"] + times
        @end_times = ["Select End Time"] + times
        render 'new_preference'
    end
    
    def preference_params
        params.require(:preference)
            .permit(preference_entries_attributes:[:preference_type, :comments,:_destroy, 
                entry_occurences_attributes:[:su, :m, :tu, :w, :th, :f, :sa, :start_time, :end_time, :_destroy]])
    end
    
    def show_preferences
        @preferences = current_user.preferences.all
        render 'show_preference'
    end
    
    def home
        if !user_signed_in?
            redirect_to new_user_session_path
        end
        render 'dashboard'
    end
end
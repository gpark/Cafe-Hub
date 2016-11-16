class DashboardController < ApplicationController
    def create_preference
        pref = current_user.preferences.new(preference_params)
        if pref.save
            redirect_to '/dashboard/preferences', notice: "Preference submitted successfully."
        else
            redirect_to '/dashboard/new_preference', alert: "Error creating preference."
        end
    end
    
    def new_preference
        if current_user.preferences.length > 0
            @preference= current_user.preferences.order(:created_at).last
        else
            @preference = current_user.preferences.new
            @preference_entry = @preference.preference_entries.new
            @entry_occurence = @preference_entry.occurences.new            
        end
        times = Array.new(24.hours / 30.minutes) {|i| [(Time.now.midnight + (i*30.minutes)).strftime("%I:%M %p"), (Time.now.midnight + (i*30.minutes)).strftime("%I:%M %p")]}
        @start_times = ["Select Start Time"] + times
        @end_times = ["Select End Time"] + times
        render 'new_preference'
    end
    
    def preference_params
        params.require(:preference)
            .permit(preference_entries_attributes:[:preference_type, :comments,:_destroy, 
                occurences_attributes:[:su, :m, :tu, :w, :th, :f, :sa, :start_time, :end_time, :_destroy]])
    end
    
    def show_preferences
        @preference = current_user.preferences.order(:created_at).last
        if @preference == nil
            redirect_to '/dashboard/new_preference', alert: "You have not submitted any preferences. Please submit one."
        else
            render 'show_preference'
        end
    end
    
    def home
        if !user_signed_in?
            redirect_to new_user_session_path
        end
        @user = current_user
        @weeks = AssignmentsWeek.order(created_at: :desc).map{|item| [item.to_s, item.id]}
        if @weeks.length > 0
            @chosen_week = @weeks[0][1]
        else
            @chosen_week = 0
        end  
        render 'dashboard'
    end
end
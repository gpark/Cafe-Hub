class AssignmentsController < ApplicationController
    def new
        @assignment = Assignment.new
        # @occurence = @assignment.occurences.new
        @assignments_weeks = AssignmentsWeek.all.collect {|a| [a.start_date.to_s + " to " + a.end_date.to_s, a.id]}
        @users = User.all.collect {|a| [a.name, a.id]}
        @facilities = Facility.all.collect {|a| [a.name, a.id]}
        times = Array.new(24.hours / 30.minutes) {|i| [(Time.now.midnight + (i*30.minutes)).strftime("%I:%M %p"), (Time.now.midnight + (i*30.minutes)).strftime("%I:%M %p")]}
        @start_times = ["Select Start Time"] + times
        @end_times = ["Select End Time"] + times
    end
    
    def create
        @assignment = Assignment.new(assignment_params)
        if @assignment.save
            redirect_to facilities_path(@assignment.facility_id), notice: "Assignment created"
        else
            redirect_to new_assignments_path, alert: "Error creating assignment."
        end
    end
    
    def assignment_params
      params.require(:assignment).permit(:user_id, :facility_id, :assignments_week_id, occurences_attributes:[:su, :m, :tu, :w, :th, :f, :sa, :start_time, :end_time, :_destroy])
    end  
    
end

class AssignmentsController < ApplicationController
    authorize_resource
    
    def new
        @assignment = Assignment.new
        @occurence = @assignment.occurences.new
        @assignments_weeks = AssignmentsWeek.order(created_at: :desc).collect {|a| [a.to_s, a.id]}
        @users = User.all.collect {|a| [a.name, a.id]}
        @facilities = Facility.all.collect {|a| [a.name, a.id]}
        times = ["12:00 AM"] + (1..11).map {|h| "#{h}:00 AM"}.to_a + ["12:00 PM"] + (1..11).map {|h| "#{h}:00 PM"}.to_a
        @start_times = ["Select Start Time"] + times
        @end_times = ["Select End Time"] + times
    end
    
    def create
        @assignment = Assignment.new(assignment_params)
        if @assignment.save
            redirect_to facilities_path(@assignment.facility_id, :assignments_week_id => @assignment.assignments_week_id), notice: "Assignment created"
        else
            redirect_to new_assignments_path, alert: "Error creating assignment."
        end
    end
    
    def assignment_params
      params.require(:assignment).permit(:user_id, :facility_id, :assignments_week_id, occurences_attributes:[:su, :m, :tu, :w, :th, :f, :sa, :start_time, :end_time, :_destroy])
    end  
    
end

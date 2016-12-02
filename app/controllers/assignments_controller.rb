class AssignmentsController < ApplicationController
    authorize_resource
    
    def new
        @assignment = Assignment.new
        @assignments_weeks = AssignmentsWeek.order(created_at: :desc).collect {|a| [a.to_s, a.id]}
        @users = User.all.collect {|a| [a.name, a.id]}
        @days = [["Su", "su"], ["M", "m"], ["Tu", "tu"], ["W", "w"], ["Th", "th"], ["F", "f"], ["Sa", "sa"]]
        @facilities = Facility.all.collect {|a| [a.name, a.id]}
        @times = get_all_times
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
      params.require(:assignment).permit(:user_id, :facility_id, :assignments_week_id, :day, :start_time, :end_time)
    end  
    
end

class AssignmentsWeeksController < ApplicationController
    def new
        @assignments_week = AssignmentsWeek.new
        
    end
    
    def create
        @assignments_week = AssignmentsWeek.new(assignments_week_params)
        if @assignments_week.save
            redirect_to assignments_weeks_path(@assignments_week.id), notice: "Week created"
        else
            redirect_to new_assignments_weeks_path, alert: "Error creating week."
        end
    end
    
    def show
        @assignments_week = AssignmentsWeek.find(params[:format])
    end
    
    def assignments_week_params
       params.require(:assignments_week).permit(:name) 
    end
end

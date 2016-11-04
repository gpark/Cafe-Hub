class AssignmentsWeeksController < ApplicationController
    authorize_resource
    
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
        if AssignmentsWeek.all.length == 0
            redirect_to new_assignments_weeks_path, alert: "There are no weeks existing. Please create one."
        else
            id = params[:format]
            if (params.key?(:chosen_week))
                @assignments_week = AssignmentsWeek.find(params[:chosen_week])        
            elsif (id == nil) 
                redirect_to assignments_weeks_path(AssignmentsWeek.order(:created_at).last.id)
            else
                @assignments_week = AssignmentsWeek.find(id)
            end
            @facilities = Facility.all
            @weeks = AssignmentsWeek.order(created_at: :desc).map{|item| [item.to_s, item.id]}
        end
    end
    
    def assignments_week_params
       params.require(:assignments_week).permit(:start_date, :end_date) 
    end
end

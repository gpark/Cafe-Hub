class SubsController < ApplicationController
    def show
        @weeks = AssignmentsWeek.order(created_at: :desc).map{|item| [item.to_s, item.id]}
        if params.key?(:assignments_week_id)
            @chosen_week = params[:assignments_week_id]
        else
            if @weeks.length > 0
                @chosen_week = @weeks[0][1]
            else
                @chosen_week = 0
            end    
        end        
        @subs = Sub.where({assignments_week: AssignmentsWeek.find(@chosen_week)})
    end
    
    def new
        @sub = Sub.new
        @weeks = AssignmentsWeek.order(created_at: :desc).map{|item| [item.to_s, item.id]}
        @assignments = current_user.assignments.where("assignments_week_id="+@weeks[0][1].to_s).map{|item| [item.to_s, item.id]}
    end
    
    def change_week
        @assignments = current_user.assignments.where("assignments_week_id="+params["selected_week"])
    end
    
    def create
        @sub = Sub.new(sub_params)
        if @sub.assignment.sub != nil
            redirect_to subs_path, alert: "Error: A sub has already been requested for this assignment"
        else
            @sub.assignments_week = @sub.assignment.assignments_week
            if @sub.save
                redirect_to subs_path, notice: "Sub created"
            else
                redirect_to new_subs_path, alert: "Sub not created"
            end            
        end
        
    end
    
    def sub_params
      params.require(:sub).permit(:comments, :created_at, :updated_at, :assignment_id)
    end 
end
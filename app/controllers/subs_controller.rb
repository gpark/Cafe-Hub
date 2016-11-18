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
        @assignments = current_user.assignments
        if !@assignments.empty?
            @assignments = @assignments.where("assignments_week_id="+@weeks[0][1].to_s).where.not(id: Sub.joins(:assignment)).map{|item| [item.to_s, item.id]}
        end
    end
    
    def change_week
        @assignments = current_user.assignments.where("assignments_week_id="+params["selected_week"])
    end
    
    def create
        @sub = Sub.new(sub_params)
        # if @sub.assignment.sub != nil
        #     redirect_to subs_path, alert: "Error: A sub has already been requested for this assignment"
        # else
        @sub.assignments_week = @sub.assignment.assignments_week
        if @sub.save
            redirect_to subs_path, notice: "Sub created"
        else
            redirect_to new_subs_path, alert: "Sub not created"
        end            
        # end
        
    end
    
    def sub_params
      params.require(:sub).permit(:comments, :created_at, :updated_at, :assignment_id)
    end
    
    def take
        # byebug
        sub = Sub.find(params[:sub_id])
        assignment = Assignment.find(sub.assignment_id)
        # byebug
        if (sub.assignment.user != current_user)
            assignment.user_id = current_user.id
            assignment.sub = nil
            facility = assignment.facility.name
            day = assignment.day
            start_time = assignment.start_time
            end_time = assignment.end_time 
            if assignment.save
                Sub.delete(params[:sub_id])
                redirect_to dashboard_path, notice: "You have taken the assignment for " + facility + " on " + day + " from " + start_time + " to " + end_time + "."
            else
                redirect_to subs_path, alert: "There was an error."
            end
        else
            redirect_to subs_path, alert: "This is your own assignment."
        end
    end
end
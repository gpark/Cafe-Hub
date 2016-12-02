class UsersController < ApplicationController
    
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def destroy
    assignment = Assignment.find(params[:assignment_id])
    user = assignment.user_id
    week_id = assignment.assignments_week_id
    assignment.destroy
    flash[:notice] = "Assignment deleted."
    redirect_to :controller => 'users', :action => 'assignments', :id => user, :assignments_week_id => week_id
  end
  
  def delete_assignments
    @user = User.find(params[:id])
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
    assignments = @user.assignments
    if !assignments.empty?
        if @chosen_week == 0
          assignments = {}
        else
          assignments = assignments.where("assignments_week_id="+@chosen_week.to_s)
        end
    end
    @assignments = assignments.map{|item| [item, item.id]}
    render 'delete'
  end

  def preference
    @user = User.find(params[:id])
    preference = @user.preferences.order(:created_at).last
    if (preference == nil)
      @preference_hash = {"su": {}, "m": {},"tu":{},"w":{},"th":{},"f":{},"sa":{}}
    else
      @preference_hash = preference.entries_hash
    end
    render 'preference'
  end
  
  def assignments
    @user = User.find(params[:id])
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
    @assignment_hash = @user.assignments_hash(@chosen_week)
    render 'assignments'
  end
  
  def all
    @users = User.all
    render 'all'
  end
  
  def privileges
    if not current_user.admin?
      raise CanCan::AccessDenied.new
    end
    
    if params[:confirm].to_s != Setting.sign_up_code.to_s
      redirect_to users_all_path, alert: "Wrong code"
    elsif params[:tag_ids].nil?
      redirect_to users_all_path
    else
      for tag_id in params[:tag_ids] do
        user = User.find(tag_id)
        user.admin = true
        user.save!
      end
      redirect_to users_all_path, notice: "Admins updated"
    end
  end
  
end

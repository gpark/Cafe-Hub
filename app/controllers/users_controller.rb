class UsersController < ApplicationController
    
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    end
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
  
end

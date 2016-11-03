class UsersController < ApplicationController
    
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end
  
  def preference
    @user = User.find(params[:id])
    @preference = @user.preferences.order(:created_at).last
    render 'preference'
  end
  
  def assignments
    @user = User.find(params[:id])
    render 'assignments'
  end
  
  def all
    @users = User.all
    render 'all'
  end
  
end

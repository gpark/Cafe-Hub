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
    render 'assignments'
  end
  
  def all
    @users = User.all
    render 'all'
  end
  
end

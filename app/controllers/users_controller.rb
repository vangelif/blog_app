class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def switch_user
    sign_out(current_user)
    redirect_to new_user_session_path
  end

end

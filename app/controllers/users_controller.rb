class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user, root: true }
    end
  end

  def switch_user
    sign_out(current_user)
    redirect_to new_user_session_path
  end
end

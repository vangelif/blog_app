class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # no matter which route we log in, we will be redirected
  # to the sign in page or sign up page first
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :bio, :photo, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :bio, :photo, :email, :password, :password_confirmation, :current_password)
    end
  end
end

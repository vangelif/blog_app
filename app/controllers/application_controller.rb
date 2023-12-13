class ApplicationController < ActionController::Base
  # no matter which route we log in, we will be redirected 
  # to the sign in page or sign up page first
  before_action :authenticate_user!
end

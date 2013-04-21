class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :super_admin?
  before_filter :authorize
  before_filter :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
  	!!(current_user)
  end

  def authorize  	
    unless logged_in?
      redirect_to :root, notice: "You are not authorized. Please login first"
    end
  end

  def super_admin?
    if current_user
      @current_user.role == "super"
    else
      false
    end
  end

end

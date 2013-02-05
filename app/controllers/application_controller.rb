class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :authorize

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    # elsif params[:token]
    #   @current_user ||= User.find_by_token(params[:token])      
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

end

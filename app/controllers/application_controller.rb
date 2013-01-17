class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    # elsif params[:token]
    #   @current_user ||= User.find_by_token(params[:token])      
    end
  end

end

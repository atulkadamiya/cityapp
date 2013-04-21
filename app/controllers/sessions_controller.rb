class SessionsController < ApplicationController
	skip_before_filter :authorize

  def create
  	@user = User.find_by_email(params[:email])
  	if @user and @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect_to issues_path
  	else
  		redirect_to login_url, alert: "Invalid user/password combination"
  	end
  end
  
  def destroy
    reset_session
    redirect_to :login, alert: "Logged out"
  end
end

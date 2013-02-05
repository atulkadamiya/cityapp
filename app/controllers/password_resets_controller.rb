class PasswordResetsController < ApplicationController
  skip_before_filter :authorize
  # skip_before_filter :edit_authorize

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.send_password_reset 
      redirect_to login_url, :notice => "Email sent with password reset instructions."
    else
      redirect_to :back, :alert => "Enter valid Email address"
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation] )
      redirect_to login_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
  
end

class AuthenticationsController < ApplicationController
  skip_before_filter :authorize

  def index
  	@authentications = current_user.authentications if current_user
  end

  def login(user_id)
    flash[:notice] = "Logged In successfully"
    session[:user_id] = user_id
    redirect_to current_user
  end

  def create
  	omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication && !current_user
      login(authentication.user_id)
    elsif !authentication && current_user
    	current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
    	flash[:notice] = "successfully authenticated"
    	redirect_to current_user
    elsif authentication && current_user
      flash[:alert] = "This account is already linked"
      redirect_to current_user
    else
      session[:omniauth] = omniauth.except('extra')
      redirect_to get_email_authentications_url
    end
  end

  def get_email
    omniauth = session[:omniauth]
    @already_user = User.find_by_email(omniauth[:info][:email])
    if @already_user
      @already_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "successfully authenticated"
      session[:user_id] = @already_user.id
      redirect_to @already_user
    else
      @user = User.new(:email => omniauth[:info][:email])
    end
  end

  def save_detail
    @user = User.new(params[:user])
    omniauth = session[:omniauth]
    if omniauth[:info][:first_name]
      @user.fname = omniauth[:info][:first_name]
      @user.lname = omniauth[:info][:last_name]
    else
      @user.fname = omniauth[:info][:name]
    end
    @user.password = @user.password_confirmation = SecureRandom.urlsafe_base64(n = 4)
    @user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    respond_to do |format|
      if @user.save 
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User successfully created.' }
      else
        format.html { render action: "get_email" }
      end
    end
  end


  def destroy
  	@authentication = current_user.authentications.find(params[:id])
  	@authentication.destroy
  	flash[:notice] = "Destroyed Authentication"
  	redirect_to authentications_url
  end
end

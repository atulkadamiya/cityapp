class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create, :show, :index]
  # before_filter :edit_authorize, :only => :edit
  before_filter :finder, :only => [:show, :edit]

  
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users}
    end
  end

  def edit_password
    if current_user and current_user.authenticate(params[:old_password])
      if current_user.update_attributes({:password => params[:password], :password_confirmation => params[:password_confirmation]})
        flash[:notice] = "password successfully changed"
        redirect_to current_user
      else
        flash[:alert] = "Password not correctly entered"
        redirect_to :back
      end
    else
      flash[:alert] = "Old password doesnt match"
      redirect_to :back
    end
  end 


  def show
  	respond_to do |format|
  		format.html
      format.json { render json: @user}
  	end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])    
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user }
      else        
        format.html { render action: "new" }
      end
    end
  end

  # def generate_token
  #   current_user.update_attribute(:token, SecureRandom.urlsafe_base64)
  #   redirect_to current_user
  #   flash[:notice] = "your token is #{current_user.token}"
  # end


  def update
    if current_user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to current_user
    else
      respond_to do |format|        
        format.html { render action: "edit", notice: '@user.errors' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  protected
    # def edit_authorize
    #   unless current_user.name == params[:id] || admin?
    #     redirect_to root_url, :alert => "You are not authorized to edit this user"
    #   end   
    # end

    def finder
      @user = User.find(params[:id])
    end
end

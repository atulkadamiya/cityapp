class SharesController < ApplicationController
  skip_before_filter :authorize
  # before_filter :finder, :only => [:show]

  
  def index
    @shares = Share.all
    respond_to do |format|
      format.html
      format.json { render json: @shares}
    end
  end

  def show
  	@share = Share.find(params[:id])
  	respond_to do |format|
  		format.html
      format.json { render json: @share}
  	end
  end

  def new
    @share = Share.new
  end

  def destroy
    @share = Share.find(params[:id])
    @share.destroy
    redirect_to shares_path
  end

  def create
    @share = Share.new(params[:share]) if params[:share].present?
    @share = Share.new(:image => params[:image]) if params[:image].present?
    respond_to do |format|
      if @share.save
        # format.html { redirect_to @share, notice: 'Shared Image was successfully created.' }
        format.html { render json: @share.image.url(:original), :status => 200 }
        format.json { render json: @share.image.url(:original) }        
      else        
        format.html { render action: "new" }
      end
    end
  end

end

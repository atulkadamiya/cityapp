class IssuesController < ApplicationController
  skip_before_filter :authorize, :only => [:show, :index]

	def new
		@issue = Issue.new
		# 5.times { @article.assets.build }
	end

	def create
    @issue = Issue.new(params[:issue])
    if @issue.save
      redirect_to @issue
    else
      render "new"
    end
  end

  def show
  	@issue = Issue.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @issue}
    end
  end

  def index
  	@issues = Issue.all
  	respond_to do |format|
  		format.html
  		format.json { render json: @issues }
  	end
  end

  def destroy
  	@issue = Issue.find(params[:id])
  	@issue.destroy
  	redirect_to issues_path
  end

  def edit
  	@issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.update_attributes(params[:issue])
      redirect_to @issue
    else
      render "edit"
    end

  end
end

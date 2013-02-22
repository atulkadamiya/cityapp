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
  	@issues = Issue.order('created_at desc')
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
    # attributes = {}
    # attachment_attributes = params[:issue][:attachment_attributes]
    # images_attributes = params[:issue][:images_attributes]
    # preview_attributes = params[:issue][:previews_attributes]
    # attributes.merge!(attachment_attributes)
    # attributes.merge!(images_attributes)
    # attributes.merge!(previews_attributes)
    if @issue.update_attributes(params[:issue])
      @issue.images.delete_all if params[:issue][:images_attributes].present?
      @issue.attachments.delete_all if params[:issue][:attachment_attributes].present?
      @issue.previews.delete_all if params[:issue][:previews_attributes].present?
      if @issue.update_attributes(params[:issue])
        redirect_to @issue
      else
        render "edit"
      end
    else
      render "edit"
    end

  end
end

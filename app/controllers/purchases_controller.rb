class PurchasesController < ApplicationController
  skip_before_filter :authorize

	def confirmpurchase
		code = 0
    begin
      @response = RestClient.post SANDBOX_ITUNE_URL, { "receipt-data" => params[:receipt_data], "password" => "ee3a8acbabf84db9b09f477225f08943"}, {:accept => :json } do |output, request, result, &block|
        code = output.code
        output
      end
    rescue::Errno::ECONNREFUSED
      message = "no response from api"
    end
    if code == 406
      message = "#{@response}"
      @response = nil
    end
    if params[:type] == "auto-renewal subscription"
      markIssuesAsPurchased(@response);
    elsif params[:type] == "non-consumable"
      mark_issue_as_purchased(params[:app_id], params[:user_id], params[:product_identifier])
    end
    Rails.logger.info("%"*80)
    Rails.logger.info(@response.inspect)
    if create_receipt(@response)
      render :json => { :message => "Purchased issue successfully inserted"}, :status => :ok
    else
      render :json => {:message => "Cannot update purchase issue. Please try again."}
    end
  end

  def index
    @subscription = Subscription.where(:app_id => params[:app_id], :user_id => params[:user_id]).last
    if @subscription
      @issues = Issue.where('issue_publish_date >= ? and issue_publish_date <= ?', @subscription.effective_date, @subscription.expiration_date)
      purchased_issues = @issues.collect(&:product_identifier)
      render :json => { :purchased_issues => purchased_issues, :status => "success", :subscription_active => (@subscription.expiration_date > DateTime.current) }
    else
      purchased_issues = []
      render :json => { :purchased_issues => purchased_issues, :status => "success", :subscription_active => false }      
    end
  end

  private

  def markIssuesAsPurchased(itune_data)
    start_date = itune_data["receipt"]["purchase_date_pst"];
    if (itune_data["status"] == 0)
      end_date = itune_data["latest_receipt_info"]["expires_date_formatted_pst"];
    elsif itune_data["status"] == 21006
      endDate = itune_data["latest_expired_receipt_info"]["expires_date_formatted_pst"];
    end
    update_subscription(params[:app_id], params[:user_id], start_date, end_date)
  end


  def update_subscription(app_id, user_id, start_date, expiration_date)
    Subscription.create(:app_id => app_id, :user_id => user_id, :effective_date => start_date, :expiration_date => end_date, :last_validated => Time.current)
    mark_issue_as_purchased(app_id, user_id, params[:product_identifier])
  end

  def mark_issue_as_purchased(app_id, user_id, product_id)
    Purchase.create(:app_id => app_id, :user_id => user_id, :product_identifier => product_id)
  end

  def create_receipt(response)
    @receipt = Receipt.new(@response["receipt"])
    @receipt.app_id = params[:app_id]
    @receipt.user_id = params[:user_id]
    @receipt.product_identifier = params[:product_identifier]
    @receipt.save
  end

end
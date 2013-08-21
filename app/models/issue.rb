class Issue < ActiveRecord::Base
  attr_accessible :app_id, :is_free, :issue_date, :name, :publisher, :images_attributes, :attachments_attributes, :description, :previews_attributes, :user_id, :product_identifier, :issue_publish_date
	
	validates :issue_date, :name, :publisher, :description, :product_identifier, :presence => true
	validates :images, :attachments, :previews, :presence => { :message => "not uploaded"}
	
	# validate :happened_at_is_valid_datetime
  has_many :devices_issues
  has_many :idevices, :through => :devices_issues

  def happened_at_is_valid_datetime
    errors.add(:issue_date, 'must be a valid date') if ((Date.parse(issue_date) rescue ArgumentError) == ArgumentError)
  end  

  has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments, :allow_destroy => true

  has_many :previews, :dependent => :destroy
	accepts_nested_attributes_for :previews, :allow_destroy => true


  has_many :images, :dependent => :destroy
	accepts_nested_attributes_for :images, :allow_destroy => true

	has_many :users, :through => :issues_users

	def images_urls
		uris = []
		self.images.each do |image|
			uris << image.image.url(:original)
		end
		uris
	end

	def attachment_url
		self.attachments.first.attachment.url(:original, false) if self.attachments.any?
	end

	def preview_url
		self.previews.first.item.url(:original, false) if self.previews.any?
	end


  def as_json(options = {})
    super(:except => [:created_at, :updated_at], :methods => [:images_urls, :attachment_url, :preview_url])
  end

end

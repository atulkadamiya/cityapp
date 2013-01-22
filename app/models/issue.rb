class Issue < ActiveRecord::Base
  attr_accessible :app_id, :is_free, :issue_date, :name, :publisher, :images_attributes, :attachments_attributes, :description
	
	validates :app_id, :issue_date, :name, :publisher, :description, :presence => true
	validates :images, :attachments, :presence => { :message => "not uploaded"}
	
	# validate :happened_at_is_valid_datetime

  def happened_at_is_valid_datetime
    errors.add(:issue_date, 'must be a valid date') if ((Date.parse(issue_date) rescue ArgumentError) == ArgumentError)
  end  

  has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments, :allow_destroy => true

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

	def attachments_urls
		uris = []
		self.attachments.each do |attachment|
			uris << attachment.attachment.url(:original, false)
		end
		uris
	end

  def as_json(options = {})
    super(:except => [:created_at, :updated_at], :methods => [:images_urls, :attachments_urls])
  end

end

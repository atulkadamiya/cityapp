class Issue < ActiveRecord::Base
  attr_accessible :app_id, :is_free, :issue_date, :name, :publisher, :images_attributes, :attachments_attributes
  
  has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments, :allow_destroy => true

  has_many :images, :dependent => :destroy
	accepts_nested_attributes_for :images, :allow_destroy => true

	has_many :users, :through => :issues_users

	def images_urls
		a = []
		self.images.each do |image|
			a << image.image.url(:original)
		end
		a
	end

	def attachments_urls
		a = []
		self.attachments.each do |attachment|
			a << attachment.attachment.url(:original, false)
		end
		a
	end

  def as_json(options = {})
    super(:except => [:created_at, :updated_at], :methods => [:images_urls, :attachments_urls])
  end

end

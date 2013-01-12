class Issue < ActiveRecord::Base
  attr_accessible :app_id, :is_free, :issue_date, :name, :publisher, :images_attributes, :attachments_attributes
  
  has_many :attachments, :dependent => :destroy
	accepts_nested_attributes_for :attachments, :allow_destroy => true

  has_many :images, :dependent => :destroy
	accepts_nested_attributes_for :images, :allow_destroy => true

	has_many :users, :through => :issues_users
end

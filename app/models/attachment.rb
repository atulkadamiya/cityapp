class Attachment < ActiveRecord::Base
  attr_accessible :issue_id, :attachment, :attachment_file_name

	has_attached_file :attachment,
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :path => "/:id/:filename"

  validates_attachment_content_type :attachment, :content_type => ['application/pdf']

  belongs_to :issue
end

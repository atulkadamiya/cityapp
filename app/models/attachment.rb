class Attachment < ActiveRecord::Base
  attr_accessible :issue_id, :attachment, :attachment_file_name

	has_attached_file :attachment

  belongs_to :issue
end

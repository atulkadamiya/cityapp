class Preview < ActiveRecord::Base
  attr_accessible :issue_id, :item, :item_file_name

	has_attached_file :item,
  :path => "/item/:id/:filename"

  validates_attachment_content_type :item, :content_type => ['application/pdf']

  belongs_to :issue

end

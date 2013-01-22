class Image < ActiveRecord::Base
  attr_accessible :issue_id, :image, :image_file_name
  belongs_to :issue

	has_attached_file :image,
  :styles => {
    :thumb=> "100x100#",
  },
  :path => "/:style/:id/:filename"


  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end

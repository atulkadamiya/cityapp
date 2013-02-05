class Share < ActiveRecord::Base
  attr_accessible :image

	has_attached_file :image,
  :styles => {
    :thumb=> "100x100#",
  },
  :path => "/share/:style/:id/:filename"

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']

end

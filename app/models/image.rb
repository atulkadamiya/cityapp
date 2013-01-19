class Image < ActiveRecord::Base
  attr_accessible :issue_id, :image, :image_file_name
  belongs_to :issue
	has_attached_file :image,
    :styles => {
      :thumb=> "100x100#",
      :large => "600x600>"
    }
  # def as_json(options = {})
  #   super(:except => [:created_at, :updated_at])
  # end

end

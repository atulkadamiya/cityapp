class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id
	belongs_to :user

  def as_json(options = {})
    super(:except => [:created_at, :updated_at])
  end

end

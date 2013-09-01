class Purchase < ActiveRecord::Base
  attr_accessible :app_id, :product_identifier, :user_id
end

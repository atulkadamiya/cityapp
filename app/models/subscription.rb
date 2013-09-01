class Subscription < ActiveRecord::Base
  attr_accessible :app_id, :effective_date, :expiration_date, :last_validated, :product_identifier, :user_id
end

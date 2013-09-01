class Receipt < ActiveRecord::Base
  attr_accessible :app_id, :app_item_id, :base64_receipt, :bid, :bvrs, :original_purchase_date, :original_transaction_id, :product_identifier, :purchase_date, :quantity, :transaction_id, :type, :user_id, :version_external_identifier
end

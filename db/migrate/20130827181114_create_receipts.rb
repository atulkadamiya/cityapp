class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :app_id
      t.string :quantity
      t.string :product_identifier
      t.string :type
      t.string :transaction_id
      t.string :user_id
      t.string :purchase_date
      t.string :original_purchase_date
      t.string :original_transaction_id
      t.string :app_item_id
      t.string :version_external_identifier
      t.string :bid
      t.string :bvrs
      t.text :base64_receipt

      t.timestamps
    end
  end
end

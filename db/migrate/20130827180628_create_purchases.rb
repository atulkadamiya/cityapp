class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :app_id
      t.string :user_id
      t.string :product_identifier

      t.timestamps
    end
  end
end

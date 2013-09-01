class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :app_id
      t.string :user_id
      t.string :product_identifier
      t.datetime :effective_date
      t.datetime :expiration_date
      t.datetime :last_validated

      t.timestamps
    end
  end
end

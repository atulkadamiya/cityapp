class AddPublisherAndRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :publisher, :string
    add_column :users, :role, :string
  end
end

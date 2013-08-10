class AddProductIdentifierToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :product_identifier, :string
  end
end

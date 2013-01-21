class AddDescriptionToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :description, :string
  end
end

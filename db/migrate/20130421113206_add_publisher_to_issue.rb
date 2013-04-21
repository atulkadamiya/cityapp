class AddPublisherToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :publisher_id, :integer
  end
end

class AddIssuePublishDateToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :issue_publish_date, :datetime
  end
end

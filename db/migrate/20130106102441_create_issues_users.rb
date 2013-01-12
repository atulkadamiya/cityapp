class CreateIssuesUsers < ActiveRecord::Migration
  def change
    create_table :issues_users do |t|
      t.integer :issue_id
      t.integer :user_id

      t.timestamps
    end
  end
end

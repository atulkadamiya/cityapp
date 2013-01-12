class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.date :issue_date
      t.boolean :is_free
      t.string :publisher
      t.string :app_id

      t.timestamps
    end
  end
end

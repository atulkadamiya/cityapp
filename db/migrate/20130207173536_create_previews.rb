class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.integer :issue_id

      t.timestamps
    end
  end
end

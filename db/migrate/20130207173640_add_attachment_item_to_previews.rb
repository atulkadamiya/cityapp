class AddAttachmentItemToPreviews < ActiveRecord::Migration
  def self.up
    change_table :previews do |t|
      t.has_attached_file :item
    end
  end

  def self.down
    drop_attached_file :previews, :item
  end
end

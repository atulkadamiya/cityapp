class ChangeColumnName < ActiveRecord::Migration
	def change
		change_column :issues, :description, :text
	end
end

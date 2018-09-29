class RenameTransTypeColumn < ActiveRecord::Migration[5.0]
  def change
	  rename_column :trans, :type, :trans_type
  end
end

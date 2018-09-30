class AddLinkedTranIdToTran < ActiveRecord::Migration[5.0]
  def change
    add_column :trans, :linked_tran_id, :integer
  end
end

class AddTranIndex < ActiveRecord::Migration[5.0]
  def change
	  add_index :trans, :trans_type
	  add_index :trans, [:target_entity_id, :target_entity_type]
	  add_index :trans, [:source_entity_id, :source_entity_type]
  end
end

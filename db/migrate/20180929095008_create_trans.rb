class CreateTrans < ActiveRecord::Migration[5.0]
  def change
    create_table :trans do |t|
      t.string :source_entity_type
      t.integer :source_entity_id
      t.string :target_entity_type
      t.integer :target_entity_id
      t.string :type
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end

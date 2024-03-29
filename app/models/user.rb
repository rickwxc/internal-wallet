class User < ApplicationRecord

  has_one :target_trans, -> { where target_entity_type: "User"},
       class_name: Tran, foreign_key: :target_entity_id,
	        foreign_type: :target_entity_type, dependent: :destroy

  has_one :source_trans, -> { where source_entity_type: "User"},
       class_name: Tran, foreign_key: :source_entity_id,
	        foreign_type: :source_entity_type, dependent: :destroy

	validates :name, presence: true
end

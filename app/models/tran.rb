class Tran < ApplicationRecord

	CREDIT = 'credit'
	DEBIT = 'debit'
	TRANSFER = 'transfer'
	belongs_to :source_entity, polymorphic: true
	belongs_to :target_entity, polymorphic: true

end

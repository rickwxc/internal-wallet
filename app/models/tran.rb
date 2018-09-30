require "active_record/locking/fatalistic"

class Tran < ApplicationRecord
	LOCKED = true

	CREDIT = 'credit'
	DEBIT = 'debit'
	TRANSFER = 'transfer'

	belongs_to :source_entity, polymorphic: true, optional: true
	belongs_to :target_entity, polymorphic: true, optional: true

	def self.balance(entity, lock = false)
		if lock
			Tran.lock do
				total = Tran.where(:target_entity => entity).sum(:amount)
				return total
			end
		end

		total = Tran.where(:target_entity => entity).sum(:amount)
		return total
	end

	def self.debit(entity, amount)
		if amount <= 0
			return
		end

		Tran.lock do
			bal =  self.balance(entity)
			if bal < amount
				return
			end

			trans = Tran.new
			trans.target_entity = entity
			trans.amount = - amount
			trans.trans_type = 'debit'
			trans.save
			return trans
		end
	end

	def self.credit(entity, amount)
		if amount <= 0
			return
		end

		trans = Tran.new
		trans.target_entity = entity 
		trans.amount = amount
		trans.trans_type = 'credit'
		trans.save

		trans
	end

	def self.transfer(from_entity, to_entity, amount)
		if amount <= 0
			return
		end

		Tran.lock do
			bal =  self.balance(from_entity)
			if bal < amount
				return
			end

			trans1 = Tran.new
			trans1.source_entity = from_entity
			trans1.target_entity = to_entity
			trans1.amount = amount
			trans1.trans_type = 'transfer'
			trans1.save

			trans2 = Tran.new
			trans2.source_entity = nil 
			trans2.target_entity = from_entity
			trans2.amount = - amount
			trans2.trans_type = 'transfer'
			trans2.linked_tran_id = trans1.id
			trans2.save

			return true
		end

	end

end

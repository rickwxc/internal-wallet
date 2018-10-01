require "active_record/locking/fatalistic"

class Tran < ApplicationRecord
	LOCKED = true

	CREDIT = 'credit'
	DEBIT = 'debit'
	TRANSFER = 'transfer'

	belongs_to :source_entity, polymorphic: true, optional: true
	belongs_to :target_entity, polymorphic: true

	belongs_to :linked_tran, class_name: 'Tran', foreign_key: 'linked_tran_id', :optional => true

	validates :amount, presence: true
	validates :trans_type, presence: true


	def self.system_info 
		total_debit = Tran.where(:trans_type => Tran::DEBIT).sum(:amount)
		total_credit = Tran.where(:trans_type => Tran::CREDIT).sum(:amount)
{
		:total_debit => total_debit,
		:total_credit => total_credit
}
	end

	def in_or_out 
		self.amount > 0
	end

	def extra_info
		if trans_type == Tran::TRANSFER  
			if source_entity == nil
				return "to #{linked_tran.target_entity.name}" 
			end

			return "from #{source_entity.name}" 
		end
	end

	def self.trans_list(entity)
		trans_list = Tran.where(:target_entity => entity).order('id desc')
		trans_list
	end

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

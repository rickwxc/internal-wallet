class WeController < ApplicationController

	def home
	end

	def credit
		amount = params["amount"].to_f
		entity = load_entity("entity_id")
		
		rs = Tran.credit(entity,amount)
		render :json =>{:is_done => !!rs}
	end

	def debit
		amount = params["amount"].to_f
		entity = load_entity("entity_id")
		
		rs = Tran.debit(entity,amount)
		render :json =>{:is_done => !!rs}
	end

	def transfer
		amount = params["amount"].to_f
		source = load_entity("source")
		target = load_entity("target")
		
		rs = Tran.transfer(source, target, amount)
		render :json =>{:is_done => !!rs}
	end

	def trans_list
		@entity = load_entity("entity_id")
		@balance = Tran.balance(@entity)
		@trans = Tran.trans_list(@entity)

		render :partial => 'trans_list'
	end

	private
	def load_entity(entity_id)
		entity = params[entity_id].split '_'
		entity[1].constantize.find(entity[0]) 
	end

end

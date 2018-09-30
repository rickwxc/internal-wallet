module TransHelper
	def get_trans_class(type)
		if type == 'credit'
			return 'badge badge-success'
		end
		if type == 'debit'
			return 'badge badge-warning'
		end
		if type == 'transfer'
			return 'badge badge-primary'
		end
	end
end

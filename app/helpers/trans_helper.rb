module TransHelper
	def get_in_out_class(in_or_out)
		if in_or_out
			return 'trans_in'
		end
		return 'trans_out'
	end

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

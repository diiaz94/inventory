class Bill < ActiveRecord::Base
	include ApplicationHelper	
	has_many :sales
	belongs_to :seller
	belongs_to :closure

	before_save do
		self.cantidad_total = self.sales ? self.sales.sum(:cantidad) : 0
  	end
	def fecha_c
		format_date(self.created_at)
	end

	def fecha_u
		format_date(self.updated_at)
	end

	def hora_c
		get_hour_of_date(self.created_at)
	end	
	def total_formatted
		format_price(self.total)
	end
	def id_formatted
		format_id(self.id,4)
	end	
end

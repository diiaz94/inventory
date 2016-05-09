class Download < ActiveRecord::Base
	include ApplicationHelper	
	belongs_to :deposit
	belongs_to :store
	belongs_to :product
	
	def fecha_c
		format_date(self.created_at)
	end

	def fecha_u
		format_date(self.updated_at)
	end
end

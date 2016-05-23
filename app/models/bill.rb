class Bill < ActiveRecord::Base
	include ApplicationHelper	
	has_many :sales
	belongs_to :seller

	def fecha_c
		format_date(self.created_at)
	end

	def fecha_u
		format_date(self.updated_at)
	end
end

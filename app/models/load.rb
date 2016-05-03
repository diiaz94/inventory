class Load < ActiveRecord::Base

	belongs_to :deposit
	belongs_to :product

	def fecha_c
		f = self.created_at

		(f.day<10 ? "0" : "")+f.day.to_s+"/"+
		(f.month<10 ? "0" : "" )+f.month.to_s+"/"+
		f.year.to_s + " a las "+
		(f.hour<10 ? "0" : "")+f.hour.to_s + ":"+
		(f.min<10 ? "0": "")+f.min.to_s

	end
end

class DepositsProduct < ActiveRecord::Base
	extend FriendlyId
	friendly_id :identifier, use: :slugged
	def identifier
		self.deposit.nombre + "-" + self.product.nombre 
	end	
end

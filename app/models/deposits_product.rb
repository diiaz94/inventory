class DepositsProduct < ActiveRecord::Base
	belongs_to :deposit
	belongs_to :product
	extend FriendlyId
	friendly_id :identifier, use: :slugged
	def identifier
		"Aaaa" 
	end	
end

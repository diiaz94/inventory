class Store < ActiveRecord::Base
	belongs_to :commerce
  	has_many :downloads
  	has_many :deposits, through: :downloads

  	has_many :sellers
	extend FriendlyId
  	friendly_id :nombre, use: :slugged

  	def nombre_comercio
  		self.commerce	 ? self.commerce.nombre : "S/C"
 	end
end

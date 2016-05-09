class Store < ActiveRecord::Base
	belongs_to :commerce
  	has_many :sellers

  	has_many :downloads

  	has_many :products, through: :downloads

  	has_many :deposits, through: :downloads

	extend FriendlyId
  	friendly_id :nombre, use: :slugged

  	def nombre_comercio
  		self.commerce ? self.commerce.nombre : "S/C"
 	end

 	def products_count
    	self.products.count
  	end
end

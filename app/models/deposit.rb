class Deposit < ActiveRecord::Base
  	has_many :products
  	has_many :products, through: :deposits_products
	belongs_to :commerce
  extend FriendlyId
  friendly_id :nombre, use: :slugged

  def nombre_comercio
  		self.commerce	 ? self.commerce.nombre : "S/C"
  end
end

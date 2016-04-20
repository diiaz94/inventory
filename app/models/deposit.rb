class Deposit < ActiveRecord::Base
  	has_and_belongs_to_many :products
	belongs_to :commerce
  extend FriendlyId
  friendly_id :nombre, use: :slugged

  def nombre_comercio
  		self.commerce	 ? self.commerce.nombre : "S/C"
  end
end

class Deposit < ActiveRecord::Base
  	has_many :loads
  	has_many :products, through: :loads
  	has_many :downloads
  	has_many :stores, through: :downloads
	  belongs_to :commerce
  extend FriendlyId
  friendly_id :nombre, use: :slugged

  def nombre_comercio
  		self.commerce	 ? self.commerce.nombre : "S/C"
  end
end

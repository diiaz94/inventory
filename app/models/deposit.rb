class Deposit < ActiveRecord::Base
	  belongs_to :commerce
    has_many :loads
    has_many :products, through: :loads
    has_many :downloads
    has_many :stores, through: :downloads
  extend FriendlyId
  friendly_id :nombre, use: :slugged

  def nombre_comercio
  		self.commerce	 ? self.commerce.nombre : "S/C"
  end
end

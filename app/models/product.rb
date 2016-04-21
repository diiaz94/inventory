class Product < ActiveRecord::Base
	has_many :deposits_products
  has_many :deposits, through: :deposits_products
	belongs_to :category
	belongs_to :unit
	belongs_to :brand
  extend FriendlyId
  friendly_id :nombre, use: :slugged

  def marca
  	self.brand ? self.brand.nombre : "S/M"
  end
  def categoria
  	self.category ? self.category.nombre : "S/C"
  end

  def nombre_marca
    self.nombre+" - "+self.marca
  end
end

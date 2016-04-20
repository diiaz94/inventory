class Product < ActiveRecord::Base
	has_and_belongs_to_many :deposits
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

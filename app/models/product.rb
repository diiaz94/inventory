class Product < ActiveRecord::Base
	belongs_to :category
	belongs_to :unit
	belongs_to :brand
  has_many :loads
  has_many :deposits, through: :loads
  has_many :downloads
  has_many :stores, through: :downloads

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

class Seller < ActiveRecord::Base
  has_one :user, dependent: :destroy
  belongs_to :commerce
  belongs_to :store
  accepts_nested_attributes_for :user, allow_destroy: true

  extend FriendlyId
  friendly_id :identifier, use: :slugged

  def identifier
  	self.user.cedula
  end
  def nombre_comercio
  		self.commerce	 ? self.commerce.nombre : "S/C"
 	end
end

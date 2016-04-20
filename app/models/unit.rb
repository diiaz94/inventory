class Unit < ActiveRecord::Base
	has_many :products
 	extend FriendlyId
  	friendly_id :nombre, use: :slugged
end

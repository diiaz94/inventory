class Store < ActiveRecord::Base
	belongs_to :commerce

	extend FriendlyId
  	friendly_id :nombre, use: :slugged
end

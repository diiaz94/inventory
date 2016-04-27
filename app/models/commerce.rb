class Commerce < ActiveRecord::Base
 	belongs_to :user
  	has_many :deposits
  	has_many :stores
  	has_many :sellers
  	extend FriendlyId
  	friendly_id :nombre, use: :slugged
end

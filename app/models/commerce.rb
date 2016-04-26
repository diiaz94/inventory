class Commerce < ActiveRecord::Base
 	belongs_to :user
  	has_many :deposits
  	has_many :stores
  	extend FriendlyId
  	friendly_id :nombre, use: :slugged
end

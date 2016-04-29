class Commerce < ActiveRecord::Base
 	belongs_to :user
  	has_many :deposits,dependent: :destroy
  	has_many :stores,dependent: :destroy
  	has_many :sellers,dependent: :destroy
  	extend FriendlyId
  	friendly_id :nombre, use: :slugged
end

class Commerce < ActiveRecord::Base
 	belongs_to :user
  	has_many :deposits,dependent: :destroy
  	has_many :stores,dependent: :destroy
  	has_many :sellers,dependent: :destroy
  	extend FriendlyId
  	friendly_id :nombre, use: :slugged

  	def deposits_count
  		self.deposits.count
  	end
  	def stores_count
  		self.stores.count
  	end
  	def sellers_count
  		self.sellers.count
  	end

end

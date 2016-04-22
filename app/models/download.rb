class Download < ActiveRecord::Base

	belongs_to :deposit
	belongs_to :store
	belongs_to :product

end

class Load < ActiveRecord::Base

	belongs_to :deposit
	belongs_to :product
end

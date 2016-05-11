class Sale < ActiveRecord::Base
	belongs_to :bill
	has_one :product
end
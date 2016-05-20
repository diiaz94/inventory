class Sale < ActiveRecord::Base
	belongs_to :bill
	belongs_to :product
end
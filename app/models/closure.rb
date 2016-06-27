class Closure < ActiveRecord::Base
	belongs_to :seller
  	has_many :bills

end

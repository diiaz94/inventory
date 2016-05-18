class Bill < ActiveRecord::Base
	has_many :sales
	belongs_to :seller

end

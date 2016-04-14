class Product < ActiveRecord::Base
	has_and_belongs_to_many :deposits
	belongs_to :category
 extend FriendlyId
  friendly_id :nombre, use: :slugged
end

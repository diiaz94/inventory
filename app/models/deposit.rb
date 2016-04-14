class Deposit < ActiveRecord::Base
  	has_and_belongs_to_many :products
	belongs_to :profile
  extend FriendlyId
  friendly_id :nombre, use: :slugged
end

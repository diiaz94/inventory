class Seller < ActiveRecord::Base
  has_one :user
  belongs_to :commerce
  belongs_to :store
  accepts_nested_attributes_for :user, allow_destroy: true
end

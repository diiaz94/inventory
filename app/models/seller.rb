class Seller < ActiveRecord::Base
  belongs_to :user
  belongs_to :commerce
  belongs_to :store
  accepts_nested_attributes_for :profile, allow_destroy: true
end

class Seller < ActiveRecord::Base
  belongs_to :user
  belongs_to :commerce
  belongs_to :store
end

class Commerce < ActiveRecord::Base
  belongs_to :profile
  has_many :deposits
  extend FriendlyId
  friendly_id :nombre, use: :slugged
end

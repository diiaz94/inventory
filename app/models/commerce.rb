class Commerce < ActiveRecord::Base
  belongs_to :profile
  extend FriendlyId
  friendly_id :nombre, use: :slugged
end

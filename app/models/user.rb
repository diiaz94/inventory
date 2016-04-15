class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  has_one :profile
  #enum role: [:admin, :owner, :seller]
  ##after_initialize :set_default_role, :if => :new_record?

 ## def set_default_role
   #   self.role ||= :seller
  #end
  accepts_nested_attributes_for :profile, allow_destroy: true
  extend FriendlyId
  friendly_id :cedula, use: :slugged
end

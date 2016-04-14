class User < ActiveRecord::Base
  authenticates_with_sorcery!

  #enum role: [:admin, :owner, :seller]
  ##after_initialize :set_default_role, :if => :new_record?

 ## def set_default_role
   #   self.role ||= :seller
  #end

  belongs_to :profile
  extend FriendlyId
  friendly_id :cedula, use: :slugged
end

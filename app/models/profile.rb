class Profile < ActiveRecord::Base
	has_one :user
	has_many :commerces

	extend FriendlyId
	friendly_id :identifier, use: :slugged
	def identifier
		self.user.cedula
	end	
end

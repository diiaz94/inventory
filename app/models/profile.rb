class Profile < ActiveRecord::Base
	belongs_to :user
	validates :primer_nombre, :presence => {:message => "El campo primer nombre no puede estar vacío"}
	validates :primer_apellido, :presence => {:message => "El campo primer apellido no puede estar vacío"}


	extend FriendlyId
	friendly_id :primer_nombre, use: :slugged
	def identifier
		self.user.cedula
	end	

	def short_name
		self.primer_nombre + " "+ self.primer_apellido
	end
	def complete_name
		puts "complete******"
		self.primer_nombre + " "+ self.segundo_nombre + " "+ self.primer_apellido + " "+ self.segundo_apellido
	end

	def sex_name
		self.sexo == true ? "Masculino" : "Femenino"
	end
end
	
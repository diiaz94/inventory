class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessor  :password, :password_confirmation
  has_one :profile,dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true
  extend FriendlyId
  friendly_id :cedula, use: :slugged

  enum role: [:admin, :owner, :seller]
 # after_initialize :set_default_role, :if => :new_record?

  #def set_default_role
  #    self.role ||= :seller
  #end
#Validaciones
validates :cedula, :presence => {:message => "El campo cédula no puede estar vacío"}, :numericality => {:only_integer => true, :message => "El campo cédula debe ser numérico"}
validates :cedula, :uniqueness => {:message => "Ya existe un usuario cone esta cédula"}
validates :cedula, length: { minimum: 5, maximun: 11 , message:"El campo cédula debe contener entre 5 y 11 dígitos"}
validates :password, length: {:if => :password_required?, minimum: 8 , message:"El campo contraseña debe contener al menos 8 dígitos"}
validates :password, :presence =>  { :if => :password_required?, :message => "El campo contraseña no puede estar vacío"}
validates :password, :confirmation =>  { :if => :password_required?, :message => "Las contraseñas no coinciden"}
validates :password_confirmation, :presence =>  { :if => :password_required?, :message => "El campo confirmar contraseña no puede estar vacío"}

  def password_required?
    new_record?
  end
end

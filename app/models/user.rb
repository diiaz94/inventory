class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessor  :password, :password_confirmation
  has_many :commerces
  has_one :profile, dependent: :destroy
  belongs_to :role
  belongs_to :seller
  accepts_nested_attributes_for :profile, allow_destroy: true
  extend FriendlyId
  friendly_id :cedula, use: :slugged

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

  def admin?
    self.role.nombre=="Admin"
  end

  def owner?
    self.role.nombre=="Owner"
  end

  def seller?
    self.role.nombre=="Seller"
  end

  def role_name
    puts "role******"

    if !self.role_id?
      return "S/R"
    end
    if self.admin?
      return "Administrador"
    end
    if self.owner? and self.commerces.count>0
      count = self.commerces.count
      return "Propietari"+(self.profile.sexo==true ? "": "a")+" de "+count.to_s+" Comercio"+(count>1 ? "s" : "")
    end
    if self.seller?
      return "Vendedor"+(self.profile.sexo ? "" : "a")+" en la tienda "+self.seller.store.nombre 
    end
  end
end



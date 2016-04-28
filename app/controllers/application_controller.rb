class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :require_login 
	def admin_role
		return	Role.where(nombre:"Admin")[0].id
	end
	def owner_role
		return	Role.where(nombre:"Owner")[0].id
	end
	def seller_role
		return	Role.where(nombre:"Seller")[0].id
	end
  private
	def not_authenticated
	  redirect_to login_path, alert: "Debes iniciar sesion primero"
	end
end

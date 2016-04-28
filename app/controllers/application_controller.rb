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

	def get_commerce(id)
		if(id)
	        @commerce = Commerce.friendly.find(params[:commerce_id])
	        
	        if current_user.admin? or(current_user.owner? and current_user.commerces.find(@commerce.id))
	        	return @commerce
	        else
	        	redirect_to login_path, alert: "No tienes acceso  a esta sección"
	        end
      	end
	end
  private
	def not_authenticated
	  redirect_to login_path, alert: "Debes iniciar sesion primero"
	end
end

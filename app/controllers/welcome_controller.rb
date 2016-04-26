class WelcomeController < ApplicationController
  def index
  	if User.all.count==0
  		@create_user_admin=true
  		@user = User.new
  		render "register_admin" , layout: "blank"
  	else
  		if !current_user
  			redirect_to(login_path)
  		end
  	end
  end

  def create_admin_user
  	@user = User.new(user_params)
	roles=Role.where(nombre: "Admin")
	if roles.length>0
		@user.role_id =  roles[0].id
		if @user.save
			redirect_to login_path
	    else
	    	render "register_admin" , layout: "blank",alert: "Lo sentimos, no se ha podido crear el usuario Administrador."
	    	return
	    end
	else
	    render "register_admin" , layout: "blank" ,alert: "Lo sentimos, no se ha podido crear el usuario Administrador."
		return
	end
  end

  	private
	  # Never trust parameters from the scary internet, only allow the white list through.
	def user_params
	  params.require(:user).permit(:cedula, :password, :password_confirmation,profile_attributes: [:id,:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :email, :celular, :_destroy])
	end
end

class SessionsController < ApplicationController
skip_before_action :require_login, except: [:destroy]
before_action :validate_users, only: [:new]

	def new
		if current_user
			redirect_back_or_to(root_path,notice:"Usted ya esta logeado con la cedula " + current_user.cedula)
		else
			@user = User.new
			render "new" , layout: "blank"
		end
		
	end
	def create
		if @user = login(params[:cedula],params[:password])
			puts "CORRECT"
			$months=[
		        "Enero",
		        "Febrero",
		        "Marzo",
		        "Abril",
		        "Mayo",
		        "Junio",
		        "Julio",
		        "Agosto",
		        "Septiembre",
		        "Octubre",
		        "Noviembre",
		        "Diciembre"
		      ]

			redirect_back_or_to(root_path,notice:"Inicio de sesion exitoso.")

		else			
			redirect_to(login_path,alert:"Revise los datos ingresados")
		end
	end
	def destroy
		logout
		redirect_to(login_path,notice: "Ha cerrado sesion correctamente.");
	end
	private 
	def validate_users
      if User.all.length == 0
        puts "not User************"
        redirect_to(admin_user_path,notice:"Debes crear el usuario administrador")
      end
    end
end

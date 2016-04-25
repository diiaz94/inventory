class SessionsController < ApplicationController
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
	def culminate_login
		if params[:opcion]=="1"
			session[:type_user] = "Administrador";
		end
		if params[:opcion]=="2"
			session[:type_user] = "Miembro";
		end
		if params[:opcion]=="3"
			session[:type_user] = "SimpleUser";
		end
		puts "**************" + session[:type_user]
		redirect_back_or_to(root_path,notice:"Inicio de sesion exitoso.")
	end
end

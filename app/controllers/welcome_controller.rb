class WelcomeController < ApplicationController
  def index
  	if User.all.count==0
  		render "register_admin" , layout: "blank"
  	else
  		if !current_user
  			redirect_to(login_path,alert: "Lo sentimos, debe iniciar sesión primero")
  		end
  	end
  end
end

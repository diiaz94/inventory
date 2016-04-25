class WelcomeController < ApplicationController
  def index
  	if User.all.count==0
  		render "register_admin" , layout: "blank"
  	end
  end
end

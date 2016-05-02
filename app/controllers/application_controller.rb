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

	def set_commerce
		if(params[:commerce_id])
            @commerce = current_user.commerces.friendly.find(params[:commerce_id])

      	end
	end

	require "rubygems"
	require "net/https"
	require "uri"
	require "json"

	def getCurrentTime
	  begin
	    puts "Begin******"

	    uri = URI.parse("http://api.timezonedb.com/?zone=America/Caracas&format=json&key=ZKLS5YG2UNIH")
	    http = Net::HTTP.new(uri.host, uri.port)
	    request = Net::HTTP::Get.new(uri.request_uri)
	 
	    res = http.request(request)
	    response = JSON.parse(res.body)

	    if(response["status"] and response["status"]=="OK" and response["timestamp"])
	      puts "OK****"
	     puts DateTime.strptime(response["timestamp"].to_s,'%s').to_formatted_s(:db).to_s 
	     
	      return DateTime.strptime(response["timestamp"].to_s,'%s').to_formatted_s(:db) 

	    else
	    return  "null"
	    end
	  rescue
	    return "null"
	  end  
	end  

  private
	def not_authenticated
	  redirect_to login_path, alert: "Debes iniciar sesion primero"
	end
end

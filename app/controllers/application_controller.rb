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
		if params[:commerce_id]
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

	    uri = URI.parse("http://api.timezonedb.com/?zone=America/Asuncion&format=json&key=ZKLS5YG2UNIH")
	    http = Net::HTTP.new(uri.host, uri.port)
	    request = Net::HTTP::Get.new(uri.request_uri)
	 
	    res = http.request(request)
	    response = JSON.parse(res.body)

	    if(response["status"] and response["status"]=="OK" and response["timestamp"])
	      puts "OK****"
	     puts DateTime.strptime(response["timestamp"].to_s,'%s').to_formatted_s(:db).to_s 
	     
	      return DateTime.strptime(response["timestamp"].to_s,'%s').to_formatted_s(:db) 

	    else
	    	puts "Error en webservice::"
	    return  nil
	    end
	  rescue
	    return nil
	  end  
	end  

def descarga_valida(download)
  
    loads = download.deposit.loads.where(product_id: download.product_id)
    if loads.sum(:cantidad)<download.cantidad
    	return false
    else
      cantidad_cargada=download.cantidad
      loads.order(:created_at).each do |load|
        if cantidad_cargada==0 and load.cantidad!=0
          break;
        else
          if load.cantidad>=cantidad_cargada
            load.cantidad=load.cantidad-cantidad_cargada
            load.save
            break;
          else
            cantidad_cargada=cantidad_cargada-load.cantidad
            load.cantidad=0
            load.save
          end  
        end
      end
      return true
    end
	
end


  private
	def not_authenticated
	  redirect_to login_path, alert: "Debes iniciar sesión primero"
	end
end

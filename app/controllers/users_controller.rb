class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

 # before_action :validate_password, only:[:create]
  # GET /users_url
  # GET /users.json
  def index
    if current_user.admin?
      @users = User.all
    end
  
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    puts "++++"+@user.crypted_password
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'Usuario creado exitosamente.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      @user.slug=nil
      if @user.update(user_params)
        ruta = @user==current_user ? root_path : users_path
        format.html { redirect_to ruta, notice: 'Usuario actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 def my_profile
    @user = current_user
    render 'edit'
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end
    def validate_password
      pass = params[:user][:password]
      passC = params[:password_confirmation]
           if pass and pass.strip ==""
            redirect_to(:back,alert: "El campo password no puede estar vacio")
          else
            if pass and !(/^(?=.*[A-Z]).{1,}$/.match(pass.strip))
              redirect_to(:back,alert: "El formato del password no esta correcto")
            else  
              if passC and passC.strip ==""
                redirect_to(:back,alert: "El campo confirmar password no puede estar vacio")
              else
                if pass and passC and pass !=passC
                  redirect_to(:back,alert: "Los passwords deben coincidir")
                end  
              end  
            end
          end  
         
    end

    def validate_fields_profile
      avatar = params[:profile][:photo]
      cedula = params[:profile][:cedula]
      pnombre = params[:profile][:primer_nombre]
      papellido = params[:profile][:primer_apellido]
      email = params[:profile][:email]
      telefono = params[:profile][:telefono]
      sexo = params[:profile][:sexo]
      fecha_nac =[ 
                  params[:profile]["fecha_nac(3i)"],
                  params[:profile]["fecha_nac(2i)"],
                  params[:profile]["fecha_nac(1i)"],
                ]
      fecha_ing =[ 
            params[:profile]["fecha_ing(3i)"],
            params[:profile]["fecha_ing(2i)"],
            params[:profile]["fecha_ing(1i)"],
          ]          
      if avatar!=nil
        if avatar.size>50000
          redirect_to(:back,alert: "Lo sentimos, la imagen es demasiado grande. Recuerde que la imagen debe pesar menos de 50KB y el formato debe ser JPG.") 
          return
        else
          if avatar.original_filename.split('.').last.downcase != "jpg"
            redirect_to(:back,alert: "Lo sentimos, la imagen no es formato jpg. Recuerde que la imagen debe pesar menos de 10KB y el formato debe ser JPG.")
            return
          end
        end
      end  
      
      if cedula.strip == ""

          render "new",alert: "Lo sentimos, la cedula no puede estar en blanco."
      else    
        if pnombre.strip == ""
          redirect_to(:back,alert: "Lo sentimos, el primer nombre no puede estar en blanco.")
          return
        else 
          if papellido.strip == ""
            redirect_to(:back,alert: "Lo sentimos, el primer apellido no puede estar en blanco.")
            return
          else
            if !sexo
              redirect_to(:back,alert: "Lo sentimos, debe elegir un sexo.")
              return
            else
              if email.strip == ""
                redirect_to(:back,alert: "Lo sentimos, el email no puede estar en blanco.")
                return
              else
                if telefono.strip == ""
                  redirect_to(:back,alert: "Lo sentimos, el telefono no puede estar en blanco.")
                  return
                else
                  if telefono.strip.length!=11
                    redirect_to(:back,alert: "Lo sentimos, debe ingresar un numero de celular valido (04121234567).")
                    return
                  else
                    if fecha_nac[0] == "" or fecha_nac[1] == "" or fecha_nac[2] == "" 
                      redirect_to(:back,alert: "Lo sentimos, debe elegir un fecha de nacimiento valida.")
                      return
                    else
                      if session[:type_user] != "SimpleUser" and (fecha_ing[0] == "" or fecha_ing[1] == "" or fecha_ing[2] == "") 
                        redirect_to(:back,alert: "Lo sentimos, debe elegir una fecha de ingreso valida.")
                        return
                      end
                    end
                  end
                end                   
              end                 
            end
          end 
        end
      end   
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:cedula, :password, :password_confirmation, :role_id, profile_attributes: [:id,:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :email, :celular, :_destroy])
    end

end

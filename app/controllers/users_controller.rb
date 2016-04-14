class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :validate_fields, only: [:create, :update]
  # GET /users_url
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @profile = Profile.new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'Se ha registrado exitosamente.' }
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
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end
    def validate_fields
      cedula = params[:user][:cedula]
      pass = params[:user][:password]
      passC = params[:password_confirmation]
    
      if cedula.strip ==""
        redirect_to(:back,alert: "El campo cedula no puede estar vacio")
      else
        if cedula.strip.length<0 || cedula.strip.length >11
          redirect_to(:back,alert: "Verifique la longitud del campo cedula")
        else  
          if pass.strip ==""
            redirect_to(:back,alert: "El campo password no puede estar vacio")
          else
            if !(/^(?=.*[A-Z]).{1,}$/.match(pass.strip))
              redirect_to(:back,alert: "El formato del password no esta correcto")
            else  
              if passC.strip ==""
                redirect_to(:back,alert: "El campo confirmar password no puede estar vacio")
              else
                if pass !=passC
                  redirect_to(:back,alert: "Los passwords deben coincidir")
                end  
              end  
            end
          end  
        end
      end  
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:cedula, :password, :password_confirmation, :type_id, :profile_id)
    end
end

class   UsersController < ApplicationController
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

 def my_profile
    @user = current_user
    render 'edit'
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:cedula, :password, :password_confirmation, :role_id, profile_attributes: [:id,:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :email, :celular, :_destroy])
    end

end

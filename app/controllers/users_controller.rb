class UsersController < ApplicationController
  before_action :set_user, only: [:my_profile, :update]


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
    render 'edit'
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:cedula,:role_id, profile_attributes: [:id,:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :email, :celular, :_destroy])
    end

end

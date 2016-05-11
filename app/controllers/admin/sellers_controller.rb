class SellersController < ApplicationController
  before_action :set_seller, only: [:show, :edit, :update, :destroy]
  before_action :verify_owner_role, only: [:create,:update]

  # GET /sellers
  # GET /sellers.json
  def index
    if current_user.admin?
      @sellers = Seller.all
    end
    if current_user.owner?
     @sellers=current_user.commerces.friendly.find(get_commerce(params[:commerce_id])).sellers
    end
  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show
  end

  # GET /sellers/new
  def new
    if current_user.admin?
      @seller = Seller.new
    end
    if current_user.owner?
        @commerce = get_commerce(params[:commerce_id])
        @seller = Seller.new
        @seller.commerce_id = @commerce.id
    end
  end
  # GET /commerce/:commerce_id/sellers/new

  # GET /sellers/1/edit
  def edit
    if current_user.owner?
      @commerce = get_commerce(params[:commerce_id])
    end
  end

  # POST /sellers
  # POST /sellers.json
  def create
    @seller = Seller.new(seller_params)

    respond_to do |format|
      if @seller.save
        ruta = current_user.admin? ? sellers_path : sellers_of_commerce_path(@seller.commerce.slug)
        format.html { redirect_to ruta, notice: 'Seller was successfully created.' }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        ruta = current_user.admin? ? sellers_path : sellers_of_commerce_path(@seller.commerce.slug)
        format.html { redirect_to ruta, notice: 'Seller was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller }
      else
        format.html { render :edit }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy
    @seller.destroy
    respond_to do |format|
      format.html { redirect_to sellers_url, notice: 'Seller was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end
    def verify_owner_role
      if current_user.owner?
        params[:seller][:user_attributes][:role_id]= seller_role
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seller_params
      params.require(:seller).permit(:commerce_id, :store_id,
      user_attributes: [:id, :cedula, :password, :password_confirmation, :role_id,:_destroy,
      profile_attributes: [:id,:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :email, :celular, :_destroy]
      ])
    end


    def user_params
      params.require(:user).permit(:cedula, :password, :password_confirmation, :role_id, profile_attributes: [:id,:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :email, :celular, :_destroy])
    end

end

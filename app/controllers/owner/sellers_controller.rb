class Owner::SellersController < ApplicationController
  before_action :set_commerce
  before_action :set_seller, only: [:show, :edit, :update, :destroy]

  # GET /sellers
  # GET /sellers.json
  def index
    @sellers = @commerce.sellers
  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers
  # POST /sellers.json
  def create
    @seller = Seller.new(seller_params)
    @seller.commerce = @commerce
    @seller.user.role_id = seller_role
    respond_to do |format|
      if @seller.save
        format.html { redirect_to owner_commerce_sellers_path(@seller.commerce.slug), notice: 'Vendedor creado exitosamente.' }
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
      @seller.slug=nil
      if @seller.update(seller_params)
        format.html { redirect_to owner_commerce_sellers_path(@seller.commerce.slug), notice: 'Vendedor actualizado exitosamente.' }
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
      @seller = @commerce.sellers.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seller_params
      params.require(:seller).permit(:commerce_id, :store_id,
      user_attributes: [:id, :cedula, :password, :password_confirmation, :role_id,:_destroy,
      profile_attributes: [:id,:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :email, :celular, :_destroy]
      ])
    end

end

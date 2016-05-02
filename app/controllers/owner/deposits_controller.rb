class Owner::DepositsController < ApplicationController
  before_action :set_commerce
  before_action :set_deposit, only: [:show, :edit, :update, :destroy, :products,:new_product,:add_product]

  # GET /deposits
  # GET /deposits.json
  def index
    @deposits = @commerce.deposits
  end

  # GET /deposits/1
  # GET /deposits/1.json
  def show
  end

  # GET /deposits/new
  def new
      @deposit = Deposit.new
  end

  # GET /deposits/1/edit
  def edit
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)
    @deposit.commerce = @commerce
      
    respond_to do |format|
      if @deposit.save
        format.html { redirect_to owner_commerce_deposits_path(@deposit.commerce.slug), notice: 'Depósito creado exitosamente.' }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits/1
  # PATCH/PUT /deposits/1.json
  def update
    respond_to do |format|
      @deposit.slug=nil
      if @deposit.update(deposit_params)
        format.html { redirect_to owner_commerce_deposits_path(@deposit.commerce.slug), notice: 'Depósito actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @deposit }
      else
        format.html { render :edit }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposits/1
  # DELETE /deposits/1.json
  def destroy
    @deposit.destroy
    respond_to do |format|
      format.html { redirect_to deposits_url, notice: 'Deposit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def products
    @products_grouped = @deposit.loads.group_by {|load| load.product_id}
    @products = []
    @products_grouped.each do |attr_name, attr_value|
      @product = Load.new(product_id: Product.find(attr_name).id, cantidad: Load.where(id: attr_value.map(&:id)).sum(:cantidad))
      @products.push(@product)
    end
  end

  def new_product
    @load = Load.new
  end

  def add_product
    @load = Load.new(load_params)
    @load.deposit = @deposit
    respond_to do |format|
      if @load.save
        format.html { redirect_to owner_commerce_deposit_products_path(@commerce,@deposit), notice: 'Se agregó el producto al depósito exitosamente.' }
        format.json { render :show, status: :created, location: @load }
      else
        format.html { render :new }
        format.json { render json: @load.errors, status: :unprocessable_entity }
      end
    end
  end  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = @commerce.deposits.friendly.find(params[:deposit_id] ? params[:deposit_id] : params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def deposit_params
      params.require(:deposit).permit(:nombre, :descripcion)
    end
    def load_params
      params.require(:load).permit(:cantidad, :precio,:product_id)
    end    
end

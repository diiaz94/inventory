class DepositsProductsController < ApplicationController
  before_action :set_deposits_product, only: [:show, :edit, :update, :destroy]
  before_action :set_deposit, except: []
  # GET /deposits_products
  # GET /deposits_products.json
  def index
    @deposits_products = params[:deposit_id] ? DepositsProduct.where(deposit_id:@deposit.id): DepositsProduct.all
  end

  # GET /deposits_products/1
  # GET /deposits_products/1.json
  def show
  end

  # GET /deposits_products/new
  def new
    @deposits_product = DepositsProduct.new
  end

  # GET /deposits_products/1/edit
  def edit
  end

  # POST /deposits_products
  # POST /deposits_products.json
  def create
    puts deposits_product_params.to_s + "*********"
    @deposits_product = DepositsProduct.new(deposits_product_params)
    respond_to do |format|
      if @deposits_product.save
        format.html { redirect_to deposits_products_path(@deposit), notice: 'Deposits product was successfully created.' }
        format.json { render :show, status: :created, location: @deposits_product }
      else
        format.html { render :new }
        format.json { render json: @deposits_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits_products/1
  # PATCH/PUT /deposits_products/1.json
  def update
    respond_to do |format|
      if @deposits_product.update(deposits_product_params)
        format.html { redirect_to deposits_products_path(@deposit), notice: 'Deposits product was successfully updated.' }
        format.json { render :show, status: :ok, location: @deposits_product }
      else
        format.html { render :edit }
        format.json { render json: @deposits_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposits_products/1
  # DELETE /deposits_products/1.json
  def destroy
    @deposits_product.destroy
    respond_to do |format|
      format.html { redirect_to deposits_products_url, notice: 'Deposits product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposits_product
      @deposits_product = DepositsProduct.friendly.find(params[:id])
    end
    def set_deposit
      @deposit = Deposit.friendly.find(params[:deposit_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deposits_product_params
      params.require(:deposits_product).permit(:cantidad, :precio, :product_id).merge(deposit_id: @deposit.id.to_s)
    end
end

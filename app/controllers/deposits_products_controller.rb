class DepositsProductsController < ApplicationController
  before_action :set_deposits_product, only: [:show, :edit, :update, :destroy]

  # GET /deposits_products
  # GET /deposits_products.json
  def index
    @deposits_products = DepositsProduct.all
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
    @deposits_product = DepositsProduct.new(deposits_product_params)

    respond_to do |format|
      if @deposits_product.save
        format.html { redirect_to @deposits_product, notice: 'Deposits product was successfully created.' }
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
        format.html { redirect_to @deposits_product, notice: 'Deposits product was successfully updated.' }
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
      @deposits_product = DepositsProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deposits_product_params
      params.require(:deposits_product).permit(:cantidad, :precio)
    end
end

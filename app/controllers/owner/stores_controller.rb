class Owner::StoresController < ApplicationController
  before_action :set_commerce
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = @commerce.stores
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
      @store = Store.new
  end
  
  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)
    @store.commerce = @commerce
      
    respond_to do |format|
      if @store.save
        format.html { redirect_to owner_commerce_stores_path(@store.commerce.slug), notice: 'Depósito creado exitosamente.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      @store.slug=nil
      if @store.update(store_params)
        format.html { redirect_to owner_commerce_stores_path(@store.commerce.slug), notice: 'Depósito actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = @commerce.friendly.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:nombre, :direccion, :commerce_id)
    end
end

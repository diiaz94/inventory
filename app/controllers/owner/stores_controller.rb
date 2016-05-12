class Owner::StoresController < ApplicationController
  before_action :set_commerce
  before_action :set_store, only: [:show, :edit, :update, :destroy,:products,:new_product,:add_product]
  after_action :set_date_created_at, only: [:add_product]


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
  def products
    @products_grouped = @store.downloads.group_by {|download| download.product_id}
    @products = []
    @products_grouped.each do |attr_name, attr_value|
      downloads = Download.where(id: attr_value.map(&:id)).order(:created_at)
      @product = Download.new(product_id: Product.find(attr_name).id, 
                              cantidad: downloads.sum(:cantidad),
                              precio: downloads.last.precio)
      @products.push(@product)
    end
  end

  def new_product
    @download = Download.new
    @deposits = @commerce.deposits
  end

  def add_product
    @download = Download.new(download_params)
    @download.cantidad_inicial = @download.cantidad
    @download.store = @store
    if !descarga_valida(@download)
      redirect_to :back, alert: 'No existe la cantidad solicitada en el depósito.'
      return
    end

    respond_to do |format|
      if @download.save
        format.html { redirect_to owner_commerce_store_products_path(@commerce,@store), notice: 'Se agregó el producto a la tienda exitosamente.' }
        format.json { render :show, status: :created, location: @download }
      else
        format.html { render :new }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_created_at
      if params[:fecha]
        f = JSON.parse(params[:fecha])
        fecha = DateTime.new(f["anio"], f["mes"], f["dia"],  f["hora"],  f["min"],  f["seg"])
      end
      time = getCurrentTime
      @download.created_at = time ? time : (fecha ? fecha : Date.today)
      @download.updated_at = time ? time : (fecha ? fecha : Date.today)
      @download.save
    end
    def set_store
     @store = @commerce.stores.friendly.find(params[:store_id] ? params[:store_id] : params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:nombre, :direccion, :commerce_id)
    end
    def download_params
      params.require(:download).permit(:cantidad, :precio,:product_id,:deposit_id)
    end 
end

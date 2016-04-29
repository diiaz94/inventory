class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action :set_commerce, only:[:new_store_of_commerce]

  # GET /stores
  # GET /stores.json
 def index
    if current_user.admin?
      @stores = Store.all
    end
    if current_user.owner?
     @stores=current_user.commerces.friendly.find(get_commerce(params[:commerce_id])).stores
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    if current_user.admin?
      @store = Store.new
    end
    if current_user.owner?
      @commerce = get_commerce(params[:commerce_id])
      @store = Store.new
      @store.commerce_id = @commerce.id
    end
    
  end
  # GET /commerce/:commerce_id/store/new

  # GET /stores/1/edit
  def edit
    if current_user.owner?
      @commerce = get_commerce(params[:commerce_id])
    end
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        ruta = current_user.admin? ? stores_path : stores_of_commerce_path(@store.commerce.slug)
        format.html { redirect_to stores_path, notice: 'Tienda creada exitosamente.' }
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
      if @store.update(store_params)
        ruta = current_user.admin? ? stores_path : stores_of_commerce_path(@store.commerce.slug)
        format.html { redirect_to ruta, notice: 'Tienda actualizada exitosamente.' }
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
      @store = Store.friendly.find(params[:id])
    end
    def set_commerce
      if(params[:commerce_id])
        puts "******1**"
        @commerce = Commerce.friendly.find(params[:commerce_id])
        puts @commerce.to_json
        puts "******FIN**"
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:nombre, :direccion, :commerce_id)
    end
end

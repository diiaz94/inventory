class Owner::DownloadsController < ApplicationController
  before_action :set_download, only: [:show, :edit, :update, :destroy, :edit_product_of_store ,:update_product_of_store]
  before_action :set_store, only: [ :create_product_of_store,:update_product_of_store,:products_of_store,:new_product_of_store,:edit_product_of_store]

  # GET /downloads
  # GET /downloads.json
  def index
    @downloads = Download.all
  end

  # GET /downloads/1
  # GET /downloads/1.json
  def show
  end

  # GET /downloads/new
  def new
    @download = Download.new
  end

  # GET /downloads/1/edit
  def edit
  end

  # POST /downloads
  # POST /downloads.json
  def create
    @download = Download.new(download_params)

    respond_to do |format|
      if @download.save
        format.html { redirect_to @download, notice: 'Download was successfully created.' }
        format.json { render :show, status: :created, location: @download }
      else
        format.html { render :new }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /downloads/1
  # PATCH/PUT /downloads/1.json
  def update
    respond_to do |format|
      if @download.update(download_params)
        format.html { redirect_to @download, notice: 'Download was successfully updated.' }
        format.json { render :show, status: :ok, location: @download }
      else
        format.html { render :edit }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /downloads/1
  # DELETE /downloads/1.json
  def destroy
    @download.destroy
    respond_to do |format|
      format.html { redirect_to downloads_url, notice: 'Download was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_product_of_store
    @download = Download.new(download_params)
    loads = @download.deposit.loads.where(product_id: @download.product_id)
    if loads.sum(:cantidad)<@download.cantidad
      redirect_to :back, alert: 'Error.'
      return
    else
      cantidad_cargada=@download.cantidad
      loads.order(:created_at).each do |load|
        if cantidad_cargada==0 and load.cantidad!=0
          break;
        else
          if load.cantidad>=cantidad_cargada
            load.cantidad=load.cantidad-cantidad_cargada
            load.save
            break;
          else
            cantidad_cargada=cantidad_cargada-load.cantidad
            load.cantidad=0
            load.save
          end  
        end
      end
    end
    respond_to do |format|
      if @download.save
        format.html { redirect_to products_of_store_path(@store), notice: 'Se agregó el producto a la tienda exitosamente.' }
        format.json { render :show, status: :created, location: @download }
      else
        format.html { render :new }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end  
  def update_product_of_store
     respond_to do |format|
      if @download.update(download_params)
        format.html { redirect_to products_of_store_path(@store), notice: 'Se actualizó el producto a la tienda exitosamente.' }
        format.json { render :show, status: :created, location: @download }
      else
        format.html { render :new }
        format.json { render json: @download.errors, status: :unprocessable_entity }
      end
    end
  end  
  def products_of_store
   @products_grouped = @store.downloads.group_by {|download| download.product_id}
  end
  def new_product_of_store
    @download = Download.new(store_id: @store.id)
    puts "**********"
    puts "DOWNLOAD"
    puts @download.to_json
    @deposits =  @store.commerce.deposits.length>0 ? @store.commerce.deposits : []
    @products = (@deposits.length > 0 and @deposits.first.products.length>0) ? @deposits.first.products : []
    puts "**********"
    puts @products.to_json
  end
  def edit_product_of_store
    @deposits =  @store.commerce.deposits.length>0 ? @store.commerce.deposits : []
    @products = (@deposits.length > 0 and @deposits.first.products.length>0) ? @deposits.first.products : []

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_download
      @download = Download.find(params[:id])
    end
    def set_store
      @store = Store.friendly.find(params[:store_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def download_params
      params.require(:download).permit(:cantidad, :precio,:deposit_id,:product_id).merge(store_id: @store.id.to_s)
    end
end

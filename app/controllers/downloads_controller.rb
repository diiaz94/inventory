class DownloadsController < ApplicationController
  before_action :set_download, only: [:show, :edit, :update, :destroy]
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
    @download = Load.new(download_params)
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
    @downloads = @store.downloads
  end
  def new_product_of_store
    @download = Download.new(store_id: @store.id)
    @download.store_id = @store.id
    deposits =  @store.commerce.deposits
    puts "*********"
    puts deposits.to_json
    @products = []
    deposits.each_index{|index|
      p =deposits[index].products
      p.each_index{|index|
        @products << p[index]
      }
    }
  end
  def edit_product_of_store
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
      params.require(:download).permit(:cantidad, :precio,:deposit_id).merge(store_id: @store.id.to_s)
    end
end

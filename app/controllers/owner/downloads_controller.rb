class Owner::DownloadsController < ApplicationController
  before_action :set_download, only: [:show, :edit, :update, :destroy]
  after_action :set_date_created_at, only: [:create]
  after_action :set_date_updated_at, only: [:update]

  # GET /downloads
  # GET /downloads.json
  def index
    @commerces = current_user.commerces
    @downloads = []
    @commerces.each do |commerce|
      commerce.stores.each do |store|
        @downloads = @downloads + store.downloads
      end
    end
  end

  # GET /downloads/1
  # GET /downloads/1.json
  def show
  end

  # GET /downloads/new
  def new
    commerces=current_user.commerces
    deposits_count=0
    stores_count=0
    products_deposits_count =0
    products_stores_count =0
    commerces.each do |c|
      deposits = c.deposits
      stores = c.stores
      deposits_count += deposits.count
      stores_count += stores.count
      deposits.each do |d|
        products_deposits_count += d.products.count
      end

      stores.each do |s|
       products_stores_count += s.products.count
      end
    end
    puts "Cantidad de comercios::"+commerces.count.to_s
    puts "Cantidad de depositos::"+deposits_count.to_s
    puts "Cantidad de tiendas::"+stores_count.to_s
    puts "Cantidad de productos en deposito::"+products_deposits_count.to_s
    if  commerces.count == 0 or
        deposits_count == 0 or
        stores_count == 0 or
        products_deposits_count == 0 
        redirect_to(:back,alert: "Disculpa, no posees elementos para hacer una descarga.")
    end
    @download = Download.new
    @commerces = current_user.commerces

  end

  # GET /downloads/1/edit
  def edit
    @commerces = current_user.commerces
  end

  # POST /downloads
  # POST /downloads.json
  def create
    @download = Download.new(download_params)
    @download.cantidad_inicial = @download.cantidad

    if !descarga_valida(@download)
      redirect_to :back, alert: 'No existe la cantidad solicitada en el depósito.'
      return
    end
    respond_to do |format|
      if @download.save
        format.html { redirect_to owner_downloads_path, notice: 'Descarga realizada exitosamente.' }
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

    @download.cantidad = params[:download][:cantidad].to_i - @download.cantidad.to_i
    if !descarga_valida(@download)
      redirect_to :back, alert: 'No existe la cantidad solicitada en el depósito.'
      return
    end
    respond_to do |format|
      if @download.update(download_params)
        @download.cantidad_inicial = @download.cantidad
        @download.save
        format.html { redirect_to owner_downloads_path, notice: 'Descarga actualizada exitosamente.' }
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




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_download
      @download = Download.find(params[:id])
    end
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
    def set_date_updated_at
      if params[:fecha]
        f = JSON.parse(params[:fecha])
        fecha = DateTime.new(f["anio"], f["mes"], f["dia"],  f["hora"],  f["min"],  f["seg"])
      end
      time = getCurrentTime
      puts @fecha.to_s
      @download.updated_at = time ? time : (fecha ? fecha : Date.today)
      @download.save
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def download_params
      params.require(:download).permit(:cantidad, :precio,:deposit_id,:product_id,:store_id)
    end
end

class Seller::StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy,:products,:close_cash]
  include ApplicationHelper

  # GET /stores
  # GET /stores.json
  def index
    @stores = @commerce.stores
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    products()
    bills()
    today_bills()
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
  def bills
    sellers = @store.sellers
    @bills=[]
    sellers.each do|s|
      s.bills.each do|b|
        @bills.push(b)
      end
    end
  end
  def today_bills
    sellers = @store.sellers
    @time = getCurrentTime
    @time = @time ? @time : Date.today
    puts "EPAA"+@time.to_s
    selected_date = Date.parse(@time)
    @today_bills = []
    sellers.each do|s|
      selected = s.bills.where(:created_at => selected_date.beginning_of_day..selected_date.end_of_day)
      @today_bills += selected
    end
  puts "today_bills::"+@today_bills.to_s
  end
  def close_cash
    today_bills()
    puts "close_cash::"+@today_bills.to_s

    if @today_bills.size>0
      selected_date = Date.parse(@time)
      if current_user.seller.closures.where(:created_at => selected_date.beginning_of_day..selected_date.end_of_day).size==0
        @closure = Closure.new
        @closure.seller=current_user.seller
        @today_bills.each do |b|
          b.closure = @closure
          b.save
        end
        @closure.created_at=@time
        @closure.updated_at=@time
        @closure.save
        fecha = format_date_to_file(Date.parse(@time))
        $pdf = ClosePDF.new("cierre_#{fecha}.pdf",@today_bills,format_date(DateTime.parse(@time)))
        puts "PDF.FILENAME::"+$pdf.file_name
        redirect_to(seller_bills_path,notice: "Ventas del dia cerradas exitosamente")
      else
        redirect_to(:back,alert: "Disculpa, ya hiciste tu cierre de ventas del dia")
      end
    else
      redirect_to(:back,alert: "Disculpa, no existen ventas para cerrar")
    end

  end

 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
     @store = current_user.sellers.first.store
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:nombre, :direccion, :commerce_id)
    end
    def download_params
      params.require(:download).permit(:cantidad, :precio,:product_id,:deposit_id)
    end 
end

class Owner::BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  after_action :set_date_created_at, only: [:create]
  after_action :set_date_updated_at, only: [:update]
  # GET /bills
  # GET /bills.json
  def index
    @bills = Bill.all
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)
    @bill.seller = current_user.sellers.where(store_id: params[:store_id]).first
    sales = params[:sales]
 
    respond_to do |format|
      if @bill.save

        sales.each do |i, sale|
          new_sale=Sale.new
          new_sale.product_id=sale["id"].to_i
          new_sale.cantidad=sale["cantidad"].to_i
          new_sale.precio=sale["precio"].to_f
          new_sale.bill=@bill
          
          downloads = @bill.seller.store.downloads.where(product_id: new_sale.product_id)
          if downloads.sum(:cantidad)<new_sale.cantidad
            puts "Error"
          else
            cantidad_cargada=new_sale.cantidad
            downloads.order(:created_at).each do |download|
            if cantidad_cargada==0 and download.cantidad!=0
              break;
            else
              if download.cantidad>=cantidad_cargada
                download.cantidad=download.cantidad-cantidad_cargada
                download.save
                break;
              else
                cantidad_cargada=cantidad_cargada-download.cantidad
                download.cantidad=0
                download.save
                end  
              end
            end
            puts "todo ok"
          end
          new_sale.save
        end 
        @commerce = @bill.seller.commerce
        @store = @bill.seller.store

        format.html { redirect_to root_path, notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_created_at
      if params[:fecha]
        puts "Se informo la fecha desde el cliente::"+params[:fecha]
        f = JSON.parse(params[:fecha])
        fecha = DateTime.new(f["anio"], f["mes"], f["dia"],  f["hora"],  f["min"],  f["seg"])
      end
      time = getCurrentTime
      puts "Respondio el werbservice del tiempo::"+time.to_s
        
      @bill.created_at = time ? time : (fecha ? fecha : Date.today)
      @bill.updated_at = time ? time : (fecha ? fecha : Date.today)
      @bill.save
    end
    def set_date_updated_at
      if params[:fecha]
        f = JSON.parse(params[:fecha])
        fecha = DateTime.new(f["anio"], f["mes"], f["dia"],  f["hora"],  f["min"],  f["seg"])
      end
      time = getCurrentTime
      puts @fecha.to_s
      @bill.updated_at = time ? time : (fecha ? fecha : Date.today)
      @bill.save
    end 
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:total,:pago)
    end
end

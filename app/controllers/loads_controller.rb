class LoadsController < ApplicationController
  before_action :set_load, only: [:show, :edit, :update, :destroy, :edit_product_of_deposit,:update_product_of_deposit]
  before_action :set_deposit, only: [ :create_product_of_deposit,:update_product_of_deposit,:products_of_deposit,:new_product_of_deposit,:edit_product_of_deposit]

  # GET /loads
  # GET /loads.json
  def index
    @loads = Load.all
  end

  # GET /loads/1
  # GET /loads/1.json
  def show
  end

  # GET /loads/new
  def new
    @load = Load.new
  end

  # GET /loads/1/edit
  def edit
  end

  # POST /loads
  # POST /loads.json
  def create
    @load = Load.new(load_params)

    respond_to do |format|
      if @load.save
        format.html { redirect_to @load, notice: 'Load was successfully created.' }
        format.json { render :show, status: :created, location: @load }
      else
        format.html { render :new }
        format.json { render json: @load.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loads/1
  # PATCH/PUT /loads/1.json
  def update
    respond_to do |format|
      if @load.update(load_params)
        format.html { redirect_to @load, notice: 'Load was successfully updated.' }
        format.json { render :show, status: :ok, location: @load }
      else
        format.html { render :edit }
        format.json { render json: @load.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loads/1
  # DELETE /loads/1.json
  def destroy
    @load.destroy
    respond_to do |format|
      format.html { redirect_to loads_url, notice: 'Load was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def create_product_of_deposit
    @load = Load.new(load_params)
    respond_to do |format|
      if @load.save
        format.html { redirect_to products_of_deposit_path(@deposit), notice: 'Se agregó el producto al depósito exitosamente.' }
        format.json { render :show, status: :created, location: @load }
      else
        format.html { render :new }
        format.json { render json: @load.errors, status: :unprocessable_entity }
      end
    end
  end  
  def update_product_of_deposit
     respond_to do |format|
      if @load.update(load_params)
        format.html { redirect_to products_of_deposit_path(@deposit), notice: 'Se actualizó el producto del depósito exitosamente.' }
        format.json { render :show, status: :created, location: @load }
      else
        format.html { render :new }
        format.json { render json: @load.errors, status: :unprocessable_entity }
      end
    end
  end  
  def products_of_deposit
    @products_grouped = @deposit.loads.group_by {|load| load.product_id}
    @loads = @deposit.loads
    puts @products_grouped.count   
    puts @products_grouped.to_json
    puts "******************"
   end
  def new_product_of_deposit
    @load = Load.new(deposit_id: @deposit.id)
    @load.deposit_id = @deposit.id
  end
  def edit_product_of_deposit
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load
      @load = Load.find(params[:id])
    end
    def set_deposit
      @deposit = Deposit.friendly.find(params[:deposit_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_params
      params.require(:load).permit(:cantidad, :precio,:product_id).merge(deposit_id: @deposit.id.to_s)
    end
end

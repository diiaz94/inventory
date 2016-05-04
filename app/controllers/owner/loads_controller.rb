class Owner::LoadsController < ApplicationController
  before_action :set_load, only: [:show, :edit, :update, :destroy]
  after_action :set_date_created_at, only: [:create]
  after_action :set_date_updated_at, only: [:update]

  # GET /loads
  # GET /loads.json
  def index
    @commerces = current_user.commerces
    @loads = []
    @commerces.each do |commerce|
      commerce.deposits.each do |deposit|
        @loads = @loads + deposit.loads
      end
    end
  end

  # GET /loads/1
  # GET /loads/1.json
  def show
  end

  # GET /loads/new
  def new
    @load = Load.new
    @commerces = current_user.commerces
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
        format.html { redirect_to owner_loads_path, notice: 'Carga realizada exitosamente.' }
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
        format.html { redirect_to owner_loads_path, notice: 'Carga actualizada exitosamente.' }
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
      format.html { redirect_to owner_loads_path, notice: 'Load was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load
      @load = Load.find(params[:id])
    end

    def set_date_created_at
      if params[:fecha]
        f = JSON.parse(params[:fecha])
        fecha = DateTime.new(f["anio"], f["mes"], f["dia"],  f["hora"],  f["min"],  f["seg"])
      end
      time = getCurrentTime
      @load.created_at = time ? time : (fecha ? fecha : Date.today)
      @load.save
    end
    def set_date_updated_at
      if params[:fecha]
        f = JSON.parse(params[:fecha])
        fecha = DateTime.new(f.anio, f.mes, f.dia,  f.hora,  f.min,  f.seg)
      end
      time = getCurrentTime
      puts @fecha.to_s
      @load.updated_at = time ? time : (fecha ? fecha : Date.today)
      @load.save
    end    

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_params
      params.require(:load).permit(:cantidad, :precio,:product_id,:deposit_id)
    end
end

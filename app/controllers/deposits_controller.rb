class DepositsController < ApplicationController
  before_action :set_deposit, only: [:show, :edit, :update, :destroy, :products]

  # GET /deposits
  # GET /deposits.json
  def index
    if current_user.admin?
      @deposits = Deposit.all
    end
    if current_user.owner?
      @deposits=current_user.commerces.friendly.find(get_commerce(params[:commerce_id])).deposits
    end
  end


  # GET /deposits/1
  # GET /deposits/1.json
  def show
  end

  # GET /deposits/new
  def new
    if current_user.admin?
      @deposit = Deposit.new
    end
    if current_user.owner?
      @commerce = get_commerce(params[:commerce_id])
      @deposit = Deposit.new
      @deposit.commerce_id = @commerce.id
    end
    
  end
  # GET /commerce/:commerce_id/deposits/new

  # GET /deposits/1/edit
  def edit
    if current_user.owner?
      @commerce = get_commerce(params[:commerce_id])
    end
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)

    respond_to do |format|
      if @deposit.save
        ruta = current_user.admin? ? deposits_path : deposits_of_commerce_path(@deposit.commerce.slug)
        format.html { redirect_to ruta, notice: 'Depósito creado exitosamente.' }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits/1
  # PATCH/PUT /deposits/1.json
  def update
    respond_to do |format|
      @deposit.slug=nil
      if @deposit.update(deposit_params)
        ruta = current_user.admin? ? deposits_path : deposits_of_commerce_path(@deposit.commerce.slug)
        format.html { redirect_to ruta, notice: 'Depósito actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @deposit }
      else
        format.html { render :edit }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposits/1
  # DELETE /deposits/1.json
  def destroy
    @deposit.destroy
    respond_to do |format|
      format.html { redirect_to deposits_url, notice: 'Deposit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deposit_params
      params.require(:deposit).permit(:nombre, :descripcion,:commerce_id)
    end
end

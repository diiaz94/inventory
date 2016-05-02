class Owner::CommercesController < ApplicationController
  before_action :set_commerce, only: [:show, :edit, :update, :destroy]
  
  # GET /commerces
  # GET /commerces.json
  def index
      @commerces = current_user.commerces
  end

  # GET /commerces/1
  # GET /commerces/1.json
  def show
    @deposits = @commerce.deposits
    @stores = @commerce.stores
    @sellers = @commerce.sellers
  end

  # GET /commerces/new
  def new
    @commerce = Commerce.new
  end

  # GET /commerces/1/edit
  def edit
  end

  # POST /commerces
  # POST /commerces.json
  def create
    @commerce = Commerce.new(commerce_params)
    @commerce.user_id = current_user.id
    respond_to do |format|
      if @commerce.save
        format.html { redirect_to owner_commerces_path, notice: 'Comercio creado exitosamente.' }
        format.json { render :show, status: :created, location: @commerce }
      else
        format.html { render :new }
        format.json { render json: @commerce.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commerces/1
  # PATCH/PUT /commerces/1.json
  def update
    respond_to do |format|
      @commerce.slug=nil
      if @commerce.update(commerce_params)
        format.html { redirect_to owner_commerces_path, notice: 'Comercio actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @commerce }
      else
        format.html { render :edit }
        format.json { render json: @commerce.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commerces/1
  # DELETE /commerces/1.json
  def destroy
    @commerce.destroy
    respond_to do |format|
      format.html { redirect_to commerces_url, notice: 'Commerce was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def deposits
    puts "AQUII*********"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commerce
      @commerce = current_user.commerces.friendly.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def commerce_params
      params.require(:commerce).permit(:nombre, :descripcion)
    end
end

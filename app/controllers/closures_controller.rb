class ClosuresController < ApplicationController
  before_action :set_closure, only: [:show, :edit, :update, :destroy]

  # GET /closures
  # GET /closures.json
  def index
    @closures = Closure.all
  end

  # GET /closures/1
  # GET /closures/1.json
  def show
  end

  # GET /closures/new
  def new
    @closure = Closure.new
  end

  # GET /closures/1/edit
  def edit
  end

  # POST /closures
  # POST /closures.json
  def create
    @closure = Closure.new(closure_params)

    respond_to do |format|
      if @closure.save
        format.html { redirect_to @closure, notice: 'Closure was successfully created.' }
        format.json { render :show, status: :created, location: @closure }
      else
        format.html { render :new }
        format.json { render json: @closure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /closures/1
  # PATCH/PUT /closures/1.json
  def update
    respond_to do |format|
      if @closure.update(closure_params)
        format.html { redirect_to @closure, notice: 'Closure was successfully updated.' }
        format.json { render :show, status: :ok, location: @closure }
      else
        format.html { render :edit }
        format.json { render json: @closure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /closures/1
  # DELETE /closures/1.json
  def destroy
    @closure.destroy
    respond_to do |format|
      format.html { redirect_to closures_url, notice: 'Closure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_closure
      @closure = Closure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def closure_params
      params.require(:closure).permit(:seller_id)
    end
end

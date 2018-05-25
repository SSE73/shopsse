class ShoppingsController < ApplicationController

  skip_before_action :authorize, only: :create

  include CurrentCart
  before_action :set_cart, only: [:create, :update, :show]

  before_action :set_shopping, only: [:show, :edit, :update, :destroy]

  # GET /shoppings
  # GET /shoppings.json
  def index
    @shoppings = Shopping.all
  end

  #def pppcart
  #  #@shoppings = Shopping.all
  #end

  # GET /shoppings/1
  # GET /shoppings/1.json
  def show
    @shoppings = Shopping.order('updated_at DESC')
   #@shoppings = Shopping.all
  end

  # GET /shoppings/new
  def new
    @shopping = Shopping.new
  end

  # GET /shoppings/1/edit
  def edit
  end

  # POST /shoppings
  # POST /shoppings.json
  def create
    @shopping = Shopping.new(shopping_params)

    respond_to do |format|
      if @shopping.save
        format.html { redirect_to @shopping, notice: 'Shopping was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shopping }
      else
        format.html { render action: 'new' }
        format.json { render json: @shopping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoppings/1
  # PATCH/PUT /shoppings/1.json
  def update
    respond_to do |format|
      if @shopping.update(shopping_params)
        format.html { redirect_to @shopping, notice: 'Shopping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shopping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shoppings/1
  # DELETE /shoppings/1.json
  def destroy
    @shopping.destroy
    respond_to do |format|
      format.html { redirect_to shoppings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopping
      #@shopping = Shopping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shopping_params
      params.require(:shopping).permit(:tovar_id, :cart_id)
    end
end

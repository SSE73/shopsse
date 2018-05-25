class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
    authorize @carts

  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
    authorize @cart
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create

    if current_user.nil?
      @cart.user_id = 0
    else
      @cart.user_id = current_user.id
    end

    @cart = Cart.new(cart_params)
    authorize @cart

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cart }
      else
        format.html { render action: 'new' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy if @cart_id == session[:cart_id]
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to sort_tovars_sort_all_url }
      format.json { head :no_content }
    end
  end

  private

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    # redirect_to home_index_url, notice: 'Invalid cart'
    redirect_to home_index_path, notice: 'Invalid cart'

  end

  # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
      authorize @cart

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      # params[:cart]
      params.require(:cart).permit(:user_id)
    end

end

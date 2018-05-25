class OrdersController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  #skip_before_action :verify_authenticity_token

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new

    # gayout = params[:gayout]

    if @cart.line_items.empty?
      redirect_to sort_tovars_sort_all_url
      return
    end

    @cities = City.all
    @order = Order.new

    if params[:mayout] == "13"
      render layout: "layout_lk"
    else
       render layout: "order"
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create

    @cities = City.all
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @order.reception_id = params[:radios1]

    respond_to do |format|
      if @order.save
        #SSE открыть если нет личного кабинета Cart.destroy(session[:cart_id])
        session[:cart_id] = nil  #???
        OrderMailer.received(@order).deliver

        format.html { redirect_to sort_tovars_sort_all_url, notice: I18n.t('.thanks') }
        format.json { render action: 'show', status: :created, location: @order }
      else
        #@cart = current_cart
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  end


  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      authorize @order

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :telephone)
    end
end

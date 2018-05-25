class WishlistsController < ApplicationController

  include CurrentCart
  before_action :set_cart, only: [:show,:create, :update]


  before_action :set_wishlist, only: [:show, :edit, :update, :destroy]

  # GET /wishlists
  # GET /wishlists.json
  def index
    @cart=Cart.find_by(id: session[:cart_id])
    @wishlists = Wishlist.all

    if params[:mayout] == "13"
      render layout: "layout_lk"
    else
      render layout: "order"
    end

  end

  # GET /wishlists/1
  # GET /wishlists/1.json
  def show
  end

  # GET /wishlists/new
  def new
    @wishlist = Wishlist.new
  end

  # GET /wishlists/1/edit
  def edit
  end

  # POST /wishlists
  # POST /wishlists.json
  def create

    # params[:tovar_razmer_id] = 35
    @wishlist = @cart.add_tovar_wishlist(params[:tovar_razmer_id])
    if current_user.nil?
      @wishlist.user_id = 0
    else
      @wishlist.user_id = current_user.id

      if params[:line_items_del]== "1" #.and. not.nil?
        @line_item_del = LineItem.find(params[:line_items_id_del])
        @line_item_del.destroy!
      end

    end

    # @wishlist = Wishlist.new(wishlist_params)

    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully created.' }
        format.json { render :show, status: :created, location: @wishlist }
      else
        format.html { render :new }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wishlists/1
  # PATCH/PUT /wishlists/1.json
  def update
    respond_to do |format|
      if @wishlist.update(wishlist_params)
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @wishlist }
      else
        format.html { render :edit }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlists/1
  # DELETE /wishlists/1.json
  def destroy
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url, notice: 'Wishlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      @wishlist = Wishlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wishlist_params
      params.require(:wishlist).permit(:cart_id, :tovar_razmer_id, :user_id)
    end
end

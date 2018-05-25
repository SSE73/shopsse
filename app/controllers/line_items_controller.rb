class LineItemsController < ApplicationController
  skip_before_action :authorize, only: :create

  include CurrentCart
  before_action :set_cart, only: [:create, :update]

  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create

    # params[:tovar_razmer_id] = 35
    @line_item = @cart.add_tovar(params[:tovar_razmer_id])
    if current_user.nil?
        @line_item.user_id = 0
      else
      @line_item.user_id = current_user.id

      if params[:wishlists_del]== "1" #.and. not.nil?
        @wishlist_del = Wishlist.find(params[:wishlists_id_del])
        @wishlist_del.destroy!
      end

    end

    respond_to do |format|
      if @line_item.save

        format.html { redirect_to $pathtovar, notice: 'Line item was successfully created.' }

        #format.html { redirect_to tovar, notice: 'Line item was successfully created.' }
        #format.html { redirect_to tovars_url, notice: 'Line item was successfully created.' }

        #format.html { redirect_to sort_tovars_sort_all_url, notice: 'Line item was successfully created.' }

        format.js   { render action: 'show', status: :created, location: @line_item }
        format.json { render action: 'show', status: :created, location: @line_item }

      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update

    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.js{@line_items = @cart.line_items}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to sort_tovars_sort_all_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
      # authorize @line_item

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:tovar_id, :cart_id, :quantity, :price, :razmer_id,:tovar_razmer_id, :user_id)
    end
end

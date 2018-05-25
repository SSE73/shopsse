class TovarRazmersController < ApplicationController

  before_action :set_tovar, only: [:new, :create]
  before_action :set_tovar_razmer, only: [:show, :edit, :update, :destroy]

  def index
    @tovar_razmers = TovarRazmer.all
  end


  def new
    @tovar_razmer = TovarRazmer.new
    @tovar_razmer.tovar_id = params[:tovar_id]
  end

  def edit
      @tovar_razmer = TovarRazmer.find(params[:id])
  end

  def show
  end

  def create

    @tovar_razmer = TovarRazmer.new(tovar_razmer_params)

    # @colorimage = params[:tovar_razmer][:images]


    respond_to do |format|
      if @tovar_razmer.save
        @tovar_razmer.images << Image.new(imageable_id: @tovar_razmer.id)
        # @colorimage = @tovar_razmer.images
        # @tovar_razmer.images
        format.html { redirect_to edit_tovar_path(@tovar_razmer.tovar_id), notice: 'Tovar_razmer was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @tovar_razmer }
      else
        format.html { render action: 'new' }
        format.json { render json: @tovar_razmer.errors, status: :unprocessable_entity }
      end
    end


  end

  def update

    @tovar_razmer = TovarRazmer.find(params[:id])

    respond_to do |format|
      if @tovar_razmer.update(tovar_razmer_params)
        # format.html { redirect_to tovar_razmers_path, notice: 'Tovar Razmer was successfully updated.' }
        format.html { redirect_to edit_tovar_path(@tovar_razmer.tovar_id), notice: 'Tovar Razmer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tovar_razmer.errors, status: :unprocessable_entity }
      end
    end

    # @tovar = Tovar.find(params[:id])
    # respond_to do |format|
    #   if @tovar.update(tovar_params)
    #     format.html { redirect_to tovars_path, notice: 'Tovar was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @tovar.errors, status: :unprocessable_entity }
    #   end
    # end

  end

  def destroy

    @tovar_razmer = TovarRazmer.find(params[:id])

    # @tovar_razmer.destroy
    # redirect_to tovar_razmers_url, notice: "Tovar_razmer was successfully destroyed."

    @tovar_razmer.destroy
    respond_to do |format|
      format.html { redirect_to edit_tovar_path(@tovar_razmer.tovar_id) }
      format.json { head :no_content }
    end

  end


  def edit_multiple
    if (params[:tovar_razmer_ids]).nil?
      # redirect_to edit_tovar_path(@tovar_razmer.tovar_id)
      redirect_to @_env['HTTP_REFERER']
      else
        @tovar_razmers = TovarRazmer.find(params[:tovar_razmer_ids])
    end
  end

  def update_multiple

    @tovar_razmers = TovarRazmer.find(params[:tovarrazmer_ids])
    @tovar_razmers.reject! do |tovarrazmer|

      tovarrazmer.update_attributes(params.require(:tovarrazmer).permit(:price, :price_skidka,:availability,:balance,:articul,:purchase_price,:selling_price,:old_price,:tovarrazmer).reject { |k,v| v.blank? })

      # tovarrazmer.update_attributes(params[:tovarrazmer].reject { |k,v| v.blank? })
      # @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      # product.update_attributes(product_params)

    end
    if @tovar_razmers.empty?
      # redirect_to tovar_razmers_url
      # redirect_to edit_tovar_url(@tovar_razmers.tovar_id)
      # redirect_to edit_tovar_url
      # redirect_to edit_tovar_url(1)

      redirect_to edit_tovar_url($tovar_id3)

    else
      # @tovar_razmer = TovarRazmer.new(params[:tovarrazmer])
      render "edit_multiple"
    end
    # end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tovar_razmer
    @tovar_razmers = TovarRazmer.find(params[:id])
    # @tovar_razmers = TovarRazmer.find(params[:tovarrazmer_ids])
    authorize @tovar_razmers

  end
  def set_tovar
    @tovar = Tovar.find_by(id: params[:tovar_id])
    #SSE redirect_to admin_products_path, alert: 'Product Not found' if(@product.nil?)
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def tovar_razmer_params
    # params.require(:tovar_razmer).permit(:tovar_id,:razmer_id,:price, :price_skidka,:availability,:balance,:articul,:purchase_price,:selling_price,:old_price,:color_id,images_attributes: [:id, :photo])
    params.require(:tovar_razmer).permit(:tovar_id,:razmer_id,:price, :price_skidka,:availability,:balance,:articul,:purchase_price,:selling_price,:old_price,:color_id)

  end

end

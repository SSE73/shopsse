class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]
  before_action :set_tovar, only: [:new, :create]

  # GET /colors
  # GET /colors.json
  def index
    @colors = Color.all
    authorize @colors

  end

  # GET /colors/1
  # GET /colors/1.json
  def show
  end

  # GET /colors/new
  def new
    @color = Color.new
    authorize @color
  end

  # GET /colors/1/edit
  def edit
    render partial: 'edit_color_form'
  end

  # POST /colors
  # POST /colors.json
  def create
    #SSE @color = Color.new(color_params)
    @color = @tovar.colors.build(color_params)

    respond_to do |format|
      if @color.save
        format.html { redirect_to @color, notice: 'Color was successfully created.' }
        format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colors/1
  # PATCH/PUT /colors/1.json
  def update
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to @color, notice: 'Color was successfully updated.' }
        format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1
  # DELETE /colors/1.json
  def destroy
    @color.destroy
    respond_to do |format|
      format.html { redirect_to colors_url, notice: 'Color was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color
      @color = Color.find_by(id: params[:id])
      #SSE redirect_to admin_products_path, alert: 'Color not found'  if @color.nil?
      authorize @color
    end

    def set_tovar
      @tovar = Tovar.find_by(id: params.require(:tovar_id))
      #SSE redirect_to admin_products_path, alert: 'Product not found' if @product.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_params
      params.require(:color).permit(:name,:tovar_id, images_attributes: [:id, :photo])
    end

    # def cannot_destroy_color
      # flash.now[:notice] = "#{ @color.name } has sizes..It cannot be destroyed."
      # render partial: 'notice'
    # end

end

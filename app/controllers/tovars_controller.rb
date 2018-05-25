class TovarsController < ApplicationController

  helper_method :sort_column, :sort_direction

  before_action :set_tovar, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:index, :show]

  include CurrentCart
  before_action :set_cart

  before_action :app_shopping, only: [:show]

  def color_size

    @parent = params[:parent]
    @ecategories= params[:ecategories]
    # @tovarrazmers = TovarRazmer.find(@ecategories)

    # redirect_to action: "show", id: 1

  end

  def size

    # @parent = params[:parent]
    @ecategories= params[:ecategories]

    # redirect_to action: "show", id: 1

  end

  # GET /tovars
  # GET /tovars.json
  def index

    @tovars = Tovar.order(sort_column+" "+sort_direction).page(params[:page]).per(32)

    # if admin
    #   @tovars = Tovar.order(sort_column+" "+sort_direction).page(params[:page]).per(32)
    # else
      # @tovars = Tovar
      # #Устанавливаем сортировку
      # order = params[:order] == "asc" ? "asc" : "desc"
      # @tovars = @tovars.order("popul #{order}" )
    # end

      authorize @tovars

  end

  # GET /tovars/1
  # GET /tovars/1.json
  def show

    #gender = params["gender"]
    #@gender1 = params["gender"]

    #@data_radio_button = params[:radios1]
    #@submitted = params["commit"]
    #@tovars11 = params[:tovar_id]

    # ----------------------------------------------

    #FIXME_AB: What if record not found with the id provided. Handle such cases everywhere
    #fixed
    @tovar = Tovar.find_by(id: params[:id])
    #SSE @color = Color.published.find_by(id: params[:color_id])
    @color = Color.find_by(tovar_id: @tovar.id)
    redirect_to root_path, alert: 'Product not found' if(@tovar.nil? || @color.nil?)

  end

  # GET /tovars/new
  def new
    @tovar = Tovar.new
    authorize @tovar
  end

  # GET /tovars/1/edit
  def edit
  end

  # POST /tovars
  # POST /tovars.json
  def create

    @tovar = Tovar.new(tovar_params)
    authorize @tovar

    respond_to do |format|
      if @tovar.save
        format.html { redirect_to edit_tovar_path(@tovar.id), notice: 'Tovar was successfully created.' }
        format.json { render action: 'index', status: :created, location: tovars_path }

        # format.html { redirect_to tovars_path, notice: 'Tovar was successfully created.' }
        # format.json { render action: 'index', status: :created, location: tovars_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @tovar.errors, status: :unprocessable_entity }
      end
    end


  end

  # PATCH/PUT /tovars/1
  # PATCH/PUT /tovars/1.json
  def update

    @tovar = Tovar.find(params[:id])
    respond_to do |format|
      if @tovar.update(tovar_params)
        format.html { redirect_to edit_tovar_path(@tovar.id), notice: 'Tovar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tovar.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /tovars/1
  # DELETE /tovars/1.json
  def destroy

    @tovar.destroy
    respond_to do |format|
      format.html { redirect_to tovars_url }
      format.json { head :no_content }
    end

  end

  def populall

  end

  private

  def authenticate

    authenticate_user! && current_user.try(:admin?)

  end

  def app_shopping

  #  Заполнение Базы Просмотренных ранее товаров

    tovar = Tovar.find(params[:id])

    @shopping = @cart.add_tovar_shopping(tovar.id)
    #
    #respond_to do |format|

      if @shopping.save

        #@shopping = Shopping.order('updated_at DESC')
    #
    #    format.html { redirect_to $pathtovar, notice: 'Line item was successfully created.' }
    #
    #    #format.html { redirect_to tovar, notice: 'Line item was successfully created.' }
    #    #format.html { redirect_to tovars_url, notice: 'Line item was successfully created.' }
    #
    #    #format.html { redirect_to sort_tovars_sort_all_url, notice: 'Line item was successfully created.' }
    #
    #    format.json { render action: 'show', status: :created, location: @line_item }
    #
      else
    #    format.html { render action: 'new' }
    #    format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end

    #end

  #  Конец Заполнение Базы Просмотренных ранее товаров

    end

  def sort_column
    Tovar.column_names.include?(params[:sort]) ? params[:sort]: 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_tovar
    @tovar = Tovar.find(params[:id])
    authorize @tovar
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tovar_params
    params.require(:tovar).permit(:title, :description, :image_url,:photo, :price, :ed_izm_id, :manufacturer_id, :availability, :name, razmer_ids:[])
  end

  #     def tovar_params
  #       params.require(:tovar).permit(:title, :name, :razmer_tokens)
  #     end

  # def tovar_params
  #   params.require(:tovar).permit(:title, :name, razmer_ids:[])                # need '[]' for collection
  # end


end

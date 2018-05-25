class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  include CurrentCart
  before_action :set_cart

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    id = params.require(:id)
    @category = Category.find(id)
    #id1 = params[:id]
    #@tovars = @category.tovars

    @tovars = @category.tovars.order(sort_column+" "+sort_direction).page(params[:page]).per(12)

  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  #def sort_all
  #  #@tovars = Tovar.order(sort_column+" "+sort_direction)
  #  #Устанавливаем сортировку
  #  id = params.require(:id)
  #  @category = Category.find(id)
  #  @tovars = @category.tovars.where(sort_column+" "+sort_direction).page(params[:page]).per(12)
  #
  #  #@tovars = @category.tovars
  #  #@tovars = Tovar.where(sort_column+" "+sort_direction).page(params[:page]).per(12)
  #
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
      authorize @category
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params[:category]
    end

  #
  def sort_column
    @category.tovars.column_names.include?(params[:sort]) ? params[:sort]: 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction])? params[:direction] : "asc"
  end

end

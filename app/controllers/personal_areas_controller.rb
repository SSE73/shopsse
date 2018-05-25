class PersonalAreasController < ApplicationController
  before_action :set_personal_area, only: [:show, :edit, :update, :destroy]

  layout "layout_lk"

  include CurrentCart
  before_action :set_cart

  # GET /personal_areas
  # GET /personal_areas.json
  def index
    # @personal_areas = PersonalArea.all
  end

  # GET /personal_areas/1
  # GET /personal_areas/1.json
  def show
  end

  # GET /personal_areas/new
  def new
    @personal_area = PersonalArea.new
  end

  # GET /personal_areas/1/edit
  def edit
  end

  # POST /personal_areas
  # POST /personal_areas.json
  def create
    @personal_area = PersonalArea.new(personal_area_params)

    respond_to do |format|
      if @personal_area.save
        format.html { redirect_to @personal_area, notice: 'Personal area was successfully created.' }
        format.json { render :show, status: :created, location: @personal_area }
      else
        format.html { render :new }
        format.json { render json: @personal_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personal_areas/1
  # PATCH/PUT /personal_areas/1.json
  def update
    respond_to do |format|
      if @personal_area.update(personal_area_params)
        format.html { redirect_to @personal_area, notice: 'Personal area was successfully updated.' }
        format.json { render :show, status: :ok, location: @personal_area }
      else
        format.html { render :edit }
        format.json { render json: @personal_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_areas/1
  # DELETE /personal_areas/1.json
  def destroy
    @personal_area.destroy
    respond_to do |format|
      format.html { redirect_to personal_areas_url, notice: 'Personal area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delay_product
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_area
      @personal_area = PersonalArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_area_params
      params.fetch(:personal_area, {})
    end
end

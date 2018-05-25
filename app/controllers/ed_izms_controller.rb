class EdIzmsController < ApplicationController
  before_action :set_ed_izm, only: [:show, :edit, :update, :destroy]


  # GET /ed_izms
  # GET /ed_izms.json
  def index
    @ed_izms = EdIzm.all
    authorize @ed_izms

  end

  # GET /ed_izms/1
  # GET /ed_izms/1.json
  def show
  end

  # GET /ed_izms/new
  def new
    @ed_izm = EdIzm.new
    authorize @ed_izm
  end

  # GET /ed_izms/1/edit
  def edit
  end

  # POST /ed_izms
  # POST /ed_izms.json
  def create
    @ed_izm = EdIzm.new(ed_izm_params)

    respond_to do |format|
      if @ed_izm.save
        format.html { redirect_to @ed_izm, notice: 'Ed izm was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ed_izm }
      else
        format.html { render action: 'new' }
        format.json { render json: @ed_izm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ed_izms/1
  # PATCH/PUT /ed_izms/1.json
  def update
    respond_to do |format|
      if @ed_izm.update(ed_izm_params)
        format.html { redirect_to @ed_izm, notice: 'Ed izm was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ed_izm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ed_izms/1
  # DELETE /ed_izms/1.json
  def destroy
    @ed_izm.destroy
    respond_to do |format|
      format.html { redirect_to ed_izms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ed_izm
      @ed_izm = EdIzm.find(params[:id])
      authorize @ed_izm
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ed_izm_params
      params.require(:ed_izm).permit(:name, :name_short)
    end
end

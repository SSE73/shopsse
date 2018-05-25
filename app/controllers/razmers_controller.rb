class RazmersController < ApplicationController
  before_action :set_razmer, only: [:show, :edit, :update, :destroy]

  # GET /razmers
  # GET /razmers.json
  def index
    @razmers = Razmer.all
  end

  # GET /razmers/1
  # GET /razmers/1.json
  def show
  end

  # GET /razmers/new
  def new
    @razmer = Razmer.new
  end

  # GET /razmers/1/edit
  def edit
  end

  # POST /razmers
  # POST /razmers.json
  def create
    @razmer = Razmer.new(razmer_params)

    respond_to do |format|
      if @razmer.save
        format.html { redirect_to @razmer, notice: 'Razmer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @razmer }
      else
        format.html { render action: 'new' }
        format.json { render json: @razmer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /razmers/1
  # PATCH/PUT /razmers/1.json
  def update
    respond_to do |format|
      if @razmer.update(razmer_params)
        format.html { redirect_to @razmer, notice: 'Razmer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @razmer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /razmers/1
  # DELETE /razmers/1.json
  def destroy
    @razmer.destroy
    respond_to do |format|
      format.html { redirect_to razmers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_razmer
      @razmer = Razmer.find(params[:id])
      authorize @razmer

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def razmer_params
      params.require(:razmer).permit(:name)
    end
end

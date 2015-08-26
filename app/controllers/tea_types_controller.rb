class TeaTypesController < ApplicationController
  before_action :set_tea_type, only: [:show, :edit, :update, :destroy]

  # GET /tea_types
  # GET /tea_types.json
  def index
    @tea_types = TeaType.all
  end

  # GET /tea_types/1
  # GET /tea_types/1.json
  def show
  end

  # GET /tea_types/new
  def new
    @tea_type = TeaType.new
  end

  # GET /tea_types/1/edit
  def edit
  end

  # POST /tea_types
  # POST /tea_types.json
  def create
    @tea_type = TeaType.new(tea_type_params)

    respond_to do |format|
      if @tea_type.save
        format.html { redirect_to tea_types_url, notice: 'Tea type was successfully created.' }
        format.json { render :show, status: :created, location: @tea_type }
      else
        format.html { render :new }
        format.json { render json: @tea_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tea_types/1
  # PATCH/PUT /tea_types/1.json
  def update
    respond_to do |format|
      if @tea_type.update(tea_type_params)
        format.html { redirect_to tea_types_url, notice: 'Tea type was successfully updated.' }
        format.json { render :show, status: :ok, location: @tea_type }
      else
        format.html { render :edit }
        format.json { render json: @tea_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tea_types/1
  # DELETE /tea_types/1.json
  def destroy
    @tea_type.destroy
    respond_to do |format|
      format.html { redirect_to tea_types_url, notice: 'Tea type was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tea_type
      @tea_type = TeaType.find_by id: params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tea_type_params
      atts = params.require(:tea_type).permit(:name)      
      atts
    end
end

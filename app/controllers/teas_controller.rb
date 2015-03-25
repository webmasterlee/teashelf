class TeasController < ApplicationController
  before_action :set_tea, only: [:show, :edit, :update, :destroy]
  before_action :get_dropdowns, only: [:index, :new, :edit, :create, :random]

  # GET /teas
  # GET /teas.json
  def index
    if params[:sortType].blank?
      @sortType = "asc"
    else
      @sortType = params[:sortType] == "asc" ? "desc" : "asc" 
    end

    @teas = Tea.teaSort(params, @sortType, current_user.id)
  end

  # GET /teas/1
  # GET /teas/1.json
  def show
  end

  # GET /teas/new
  def new
    @tea = Tea.new
  end

  # GET /teas/1/edit
  def edit
  end

  def random
    @tea = Tea.search(params, current_user.id)
  end

  # POST /teas
  # POST /teas.json
  def create
    @tea = Tea.new(tea_params)

    respond_to do |format|
      if @tea.save
        format.html { redirect_to teas_url, notice: 'Tea was successfully created.' }
        format.json { render :show, status: :created, location: @tea }
      else
        format.html { render :new }
        format.json { render json: @tea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teas/1
  # PATCH/PUT /teas/1.json
  def update
    respond_to do |format|
      if @tea.update(tea_params)
        format.html { redirect_to teas_url, notice: 'Tea was successfully updated.' }
        format.json { render :show, status: :ok, location: @tea }
      else
        format.html { render :edit }
        format.json { render json: @tea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teas/1
  # DELETE /teas/1.json
  def destroy
    @tea.destroy
    respond_to do |format|
      format.html { redirect_to teas_url, notice: 'Tea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
     def set_tea
      @tea = Tea.find_by id: params[:id], user_id: current_user.id
    end

    def get_dropdowns
      @tea_types = TeaType.where(:user_id => current_user.id)
      @atts = Att.where(:user_id => current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tea_params
      atts = params.require(:tea).permit(:name, :stock, :tea_type_id, :url, :notes, :att_ids => [])
      atts[:user_id] = current_user.id
      atts
    end
end
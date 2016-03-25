class TeasController < ApplicationController
  before_action :set_tea, only: [:show, :edit, :update, :destroy]
  before_action :get_dropdowns, only: [ :new, :edit, :create]
  before_action :get_my_dropdowns, only: [:index, :random]

  # GET /teas
  # GET /teas.json
  def index

    if params[:sortType].blank?
      @sortType = "asc"
    else
      @sortType = params[:sortType] == "asc" ? "desc" : "asc" 
    end
    
    @teas = Tea.teaSort(params, @sortType, current_user.id).order("archive,favorite desc,name")

  end

  # GET /teas/1
  # GET /teas/1.json
  def show
    #@otherNotes = Tea.where(name: @tea.name).where.not(user_id: current_user.id).limit(20)
    @otherNotes = Tea.where("name = ? and user_id != ? and notes is not null and notes !=''", @tea.name, current_user.id).limit(20)
    #@suggestions = Tea.where(tea_type: @tea.tea_type, user_id: Tea.select("user_id").where(name: @tea.name).where.not(user_id: current_user.id)).where.not(name: @tea.name)
    @suggestions = Tea.find_by_sql(["select distinct on (name) name,vendor,url from teas where tea_type_id = ? and upper(name) != ? and user_id in (select user_id from teas where upper(name) = ? and user_id != ?) and upper(name) not in (select upper(name) from wishlists where user_id = ?) and upper(name) not in (select upper(value) from exclusions where user_id = ? and attr = 'tea_name')", @tea.tea_type_id, @tea.name.upcase,@tea.name.upcase, current_user.id, current_user.id, current_user.id ])
  end

  # GET /teas/new
  def new
    @tea = Tea.new
  end

  # GET /teas/1/edit
  def edit
  end

  def random
    @totalTeas = Tea.where(:user_id => current_user.id).count
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
      format.html { redirect_to teas_url, notice: 'Tea was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def get_tea_names
    #@tea_names = Tea.all.select("name").order("name")
    #render json: @tea_names
    @tea_names = Tea.all.pluck(:name)    
    render json: @tea_names
  end

  private
    def set_tea
      @tea = Tea.find_by id: params[:id], user_id: current_user.id
    end

    def get_my_dropdowns
      @tea_types = TeaType.find_by_sql(["select distinct a.name, a.id from tea_types a, teas b where a.id = b.tea_type_id and b.user_id = ?", current_user.id ])
      @atts = TeaType.find_by_sql(["select distinct a.name, a.id from atts a, atts_teas b where a.id = b.att_id and a.user_id = ?", current_user.id ])

    end

    def get_dropdowns
      @tea_types = TeaType.all
      @atts = Att.where(:user_id => current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tea_params
      atts = params.require(:tea).permit(:name, :stock, :tea_type_id, :favorite, :archive, :vendor, :url, :notes, :att_ids => [])
      atts[:user_id] = current_user.id
      atts
    end
end

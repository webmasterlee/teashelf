class AttsController < ApplicationController
  before_action :set_att, only: [:show, :edit, :update, :destroy]

  # GET /atts
  # GET /atts.json
  def index
    @atts = Att.where(:user_id => current_user.id)
  end

  # GET /atts/1
  # GET /atts/1.json
  def show
  end

  # GET /atts/new
  def new
    @att = Att.new
  end

  # GET /atts/1/edit
  def edit
  end

  # POST /atts
  # POST /atts.json
  def create
    @att = Att.new(att_params)

    respond_to do |format|

      attExist = Att.where(:user_id => current_user.id).limit(2)

      if @att.save

        if attExist.count == 1
          msg = ['Attribute was successfully created.','You can now this attribute to your teas!']
        else
          msg = 'Attribute was successfully created.'
        end
        
        format.html { redirect_to atts_url, notice: msg }
        format.json { render :show, status: :created, location: @att }
      else
        format.html { render :new }
        format.json { render json: @att.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /atts/1
  # PATCH/PUT /atts/1.json
  def update
    respond_to do |format|
      if @att.update(att_params)
        format.html { redirect_to atts_url, notice: 'Attribute was successfully updated.' }
        format.json { render :show, status: :ok, location: @att }
      else
        format.html { render :edit }
        format.json { render json: @att.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atts/1
  # DELETE /atts/1.json
  def destroy
    @att.destroy
    respond_to do |format|
      format.html { redirect_to atts_url, notice: 'Attribute was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_att
      @att = Att.find_by id: params[:id], user_id: current_user.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def att_params
      atts = params.require(:att).permit(:name)
      atts[:user_id] = current_user.id
      atts
    end
end

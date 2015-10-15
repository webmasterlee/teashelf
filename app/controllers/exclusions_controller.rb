class ExclusionsController < ApplicationController
  def create
    @exclusion = Exclusion.new(exclusion_params)
    @exclusion.save
    render json: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def exclusion_params
      atts = params.require(:exclusion).permit(:attr, :value)
      atts[:user_id] = current_user.id
      atts
    end
end

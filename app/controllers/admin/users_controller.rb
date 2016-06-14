class Admin::UsersController < ApplicationController
	before_action :set_user, only: [:show]

	def index
		@users = User.select("id,username,sign_in_count,newsletter,last_sign_in_at,email,created_at").where(admin: false )
	end

	def show
	end
  
  	private
  	  # Use callbacks to share common setup or constraints between actions.
  	  def set_user
  	    @user = User.find_by id: params[:id]
  	  end
end

class AccountController < ApplicationController

	skip_before_action 	:authenticate_user!, only: [:found_username]

	def found_username
		#@tea_names = Tea.all.select("name").order("name")
		#render json: @tea_names
		usernames = User.where("username = ? and id != ?", params['username'], current_user ? current_user.id : 0)
		render json: usernames.count
	end
  
end

class AccountController < ApplicationController
 
  def found_username
    #@tea_names = Tea.all.select("name").order("name")
    #render json: @tea_names
    usernames = User.where("username = ? and id != ?", params['username'], current_user.id)
    render json: usernames.count
  end
  
end

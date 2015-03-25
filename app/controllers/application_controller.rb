class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_night_mode

  def check_night_mode
  	if params[:night_mode]
	  	session[:night_mode] = params[:night_mode]
	   end
  end
end

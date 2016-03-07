class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_night_mode

  def after_sign_in_path_for(resource)
    teas_path
  end

  def check_night_mode

    if user_signed_in? && session[:night_mode].nil?
      @night_mode = Preference.find_or_initialize_by :user_id => current_user.id, name: "night_mode_default"
      
      unless @night_mode.nil?
        session[:night_mode] = @night_mode.value == "true" ? "on" : ""
      end
    end

  	if params[:night_mode]
	  	session[:night_mode] = params[:night_mode]
	   end
  end
end

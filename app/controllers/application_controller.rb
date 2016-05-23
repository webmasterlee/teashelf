class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # need to restart server for changes to take affect

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_night_mode
  before_filter :configure_permitted_parameters, if: :devise_controller?

  
  def authenticate_admin_user!
    raise ActionController::RoutingError, 'Not Found' unless current_user.try(:admin?)
  end

  def after_sign_in_path_for(resource)
    teas_path
  end

  def check_night_mode

    if user_signed_in? && session[:night_mode].nil?
      session[:night_mode] = "off"

      @night_mode = Preference.find_or_initialize_by :user_id => current_user.id, name: "night_mode_default"
      
      unless @night_mode.nil?
        session[:night_mode] = @night_mode.value == "true" ? "on" : "off"
      end
    end

  	if params[:night_mode]
	  	session[:night_mode] = params[:night_mode]
	   end
  end

  protected

  def configure_permitted_parameters
    #http://www.rubydoc.info/github/plataformatec/devise/Devise/ParameterSanitizer
    #http://stackoverflow.com/questions/34510155/cant-add-custom-fields-to-devise-model-in-ruby-on-rails-private-method-error
    devise_parameter_sanitizer.for(:account_update) << :username ## add the attributes you want to permit
    devise_parameter_sanitizer.for(:account_update) << :newsletter
    #devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end

class MyDevise::RegistrationsController < Devise::RegistrationsController

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated

      @night_mode = Preference.find_or_initialize_by(name: "night_mode_default", user_id: current_user.id)    
      @night_mode.value = params[:night_mode_default] == "true" ? "true" : "false"
      @night_mode.save

      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      set_night_mode
      clean_up_passwords resource
      respond_with resource
    end
  end

  def edit
    set_night_mode
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    if params[:user][:password].present? || params[:user][:password_confirmation].present? || params[:user][:current_password].present?
      devise_parameter_sanitizer.sanitize(:account_update)
    else
      params.require(:user).permit(:username, :email)
    end
  end

  protected

  def update_resource(resource, params)
    if params[:password].present? || params[:password_confirmation].present? || params[:current_password].present?
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  private

  def set_night_mode
    @night_mode = Preference.find_or_initialize_by :user_id => current_user.id, name: "night_mode_default"
    
    if @night_mode.blank?
      @night_mode = false
    else
      @night_mode = @night_mode.value == "true" ? true : false
    end
  end

end


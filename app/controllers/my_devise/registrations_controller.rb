class MyDevise::RegistrationsController < Devise::RegistrationsController

  def create

  #build_resource(sign_up_params)

    if verify_recaptcha(model: resource)
      super
    else
      build_resource
      clean_up_passwords(resource)
      flash[:alert] = "Sorry you didn't pass the Robot test."
      redirect_to new_user_registration_path
    end
  end



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
      #respond_with resource, location: after_update_path_for(resource)
      flash[:alert] = resource.errors.full_messages 
      redirect_to edit_user_registration_path
    end
  end

  def edit
    set_night_mode
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end




  protected

=begin
  def update_resource(resource, params)
    if params[:password].present? && params[:password_confirmation].present? || params[:current_password].present?
      resource.update_with_password(params)
    else
      params.delete :password
      params.delete :password_confirmation
      params.delete :current_password
      resource.update_without_password(params)
    end
  end
=end

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


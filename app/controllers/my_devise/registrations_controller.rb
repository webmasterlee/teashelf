class MyDevise::RegistrationsController < Devise::RegistrationsController

  def update
    super
    
    @night_mode = Preference.find_or_initialize_by(name: "night_mode_default", user_id: current_user.id)    
    @night_mode.value = params[:night_mode_default] == "true" ? "true" : "false"

    #puts YAML::dump(@prefs)
    @night_mode.save
  end

  def edit
    #super, the original method only renders the view
    @night_mode = Preference.find_by :user_id => current_user.id, name: "night_mode_default"
    @night_mode = @night_mode.value == "true" ? true : false
  end

  

end


class MyDevise::SessionsController < Devise::SessionsController

  def create
    super
    
    if user_signed_in?
      @night_mode = Preference.find_by :user_id => current_user.id, name: "night_mode_default"
      session[:night_mode] = @night_mode.value == "true" ? "on" : ""
    end
  end
  

end


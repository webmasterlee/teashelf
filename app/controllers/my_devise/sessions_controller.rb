class MyDevise::SessionsController < Devise::SessionsController

  def create
    super
    
    if user_signed_in?
      @night_mode = Preference.find_or_initialize_by :user_id => current_user.id, name: "night_mode_default"
      
      unless @night_mode.nil?
        session[:night_mode] = @night_mode.value == "true" ? "on" : ""
      end
    end
  end

  def new 
  	super
  	 if user_signed_in?
      @night_mode = Preference.find_or_initialize_by :user_id => current_user.id, name: "night_mode_default"
      
      unless @night_mode.nil?
        session[:night_mode] = @night_mode.value == "true" ? "on" : ""
      end
    end
  end
  

end


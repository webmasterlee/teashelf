class InfoController < ApplicationController
	skip_before_filter :authenticate_user!
	 
  def index
    render(:layout => "layouts/hp")
  end
  
  def contact
    @contact = Contact.new
  end

  def contact_send
    @contact = Contact.new(form_params)
    
    if @contact.valid?
      SiteMailer.contact(@contact).deliver
      redirect_to contact_path, notice: "Your messages has been sent."
    else
      flash[:alert] = @contact.errors.full_messages

      render :contact 
    end
  end

	private

  def form_params
    params.require(:contact).permit(:name, :subject, :message, :email)
  end

end

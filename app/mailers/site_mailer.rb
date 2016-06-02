class SiteMailer < ActionMailer::Base
  default from: "TeaLogger.com <#{ENV["mail_from_email"]}>"


  def contact(form_params)
  	@form_params = form_params
    
    mail to: ENV["my_email"], subject: "Contact Form: #{form_params.subject}"
  end
end
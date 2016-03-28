class SiteMailer < ActionMailer::Base
  default from: "Tea Logger <#{ENV["mail_from_email"]}>"


  def contact(form_params)
  	@form_params = form_params
    
    mail to: ENV["my_email"], subject: "Contact Form: #{form_params.subject}"
  end
end

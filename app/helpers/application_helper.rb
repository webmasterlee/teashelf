module ApplicationHelper
	def format_message(message, cssClass = "errormsg")

		results = ""

		if !message.blank? and (message.respond_to? (:each) or message.respond_to? (:to_str))

			results = "<div class='#{cssClass} js_css_msg_target'><div class='msgMargin'>"

			if message.respond_to? (:each)

				results += "<ul class='error_list'>"

				message.each do |message| 
					results += "<li>" + message + "</li>"
				end 

				results += "</ul>"
			elsif
				results += message
			end

			results += "</div></div>"
		end

		results.html_safe
	end
end

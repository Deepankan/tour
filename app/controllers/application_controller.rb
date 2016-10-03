class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter  :verify_authenticity_token
   #before_filter :switch_label
 # auto_session_timeout 30.seconds

    def remote_ip
	    if request.remote_ip == '127.0.0.1'
	      # Hard coded remote address
	      '117.217.230.222'
	    else
	      request.remote_ip
	    end
  end

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  def switch_label
      unless Whitelabel.label_for(request.subdomains.first)
        redirect_to(labels_url(subdomain: false), alert: "Please select a Label!")
      end
    end
end

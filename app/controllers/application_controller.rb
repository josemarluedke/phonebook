class ApplicationController < ActionController::Base
  protect_from_forgery

  #Render 404 error
  def render_404(options={})
    render_error({:message => :notice_file_not_found, :status => 404})
    return false
  end

  # Renders an error response
  def render_error(arg)
    arg = {:message => arg} unless arg.is_a?(Hash)

    @message = arg[:message]
    @status = arg[:status] || 500

    respond_to do |format|
      format.html {
        render :template => 'common/error', :layout => true, :status => @status
      }
      format.atom { head @status }
      format.xml { head @status }
      format.js { head @status }
      format.json { head @status }
    end
  end
  
  # After Sign in for Devise
  def after_sign_in_path_for(resource)
    contacts_path
  end
end

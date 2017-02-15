class GoogleSessionsController < ApplicationController
  include MessageHelper
  
  def create
    if @credential = GoogleCredential.from_omniauth(request.env["omniauth.auth"])
      session[:registered_user_id] = @credential.registered_user_id
      flash_message_successful_login
      redirect_to root_path
    else
      flash_message_failed_login
      redirect_to login_path
    end
  end

end

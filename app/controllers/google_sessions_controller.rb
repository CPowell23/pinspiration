class GoogleSessionsController < ApplicationController
  def create
    @credential = GoogleCredential.from_omniauth(request.env["omniauth.auth"])
    session[:registered_user_id] = @credential.registered_user_id
    redirect_to root_path
  end

end
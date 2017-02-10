class GoogleSessionsController < ApplicationController
  def create
    @credential = GoogleCredential.from_omniauth(request.env["omniauth.auth"])
    session[:registered_user_id] = @credential.registered_user_id
    flash[:success] = "Thank you for registering through google. Enjoy Pinspiration!"
    redirect_to root_path
  end

end
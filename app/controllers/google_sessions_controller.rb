class GoogleSessionsController < ApplicationController
  def create
    @credential = GoogleCredential.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = @credential.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
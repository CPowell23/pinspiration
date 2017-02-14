class SessionsController < ApplicationController
  include MessageHelper

  def new
  end

  def create
    if authenticated_pinspiration_credential?
      session[:registered_user_id] = registered_user.id
      flash_message_successful_login
      redirect_to root_path
    else
      flash_message_failed_login
      render :new
    end
  end

  def destroy
    session[:registered_user_id] = nil
    flash_message_successful_logout
    redirect_to login_path
  end

  private

    def pinspiration_credential
      PinspirationCredential.find_by(email: params[:email])
    end

    def registered_user
      pinspiration_credential.registered_user
    end

    def authenticated_pinspiration_credential?
      pinspiration_credential && pinspiration_credential.authenticate(params[:password])
    end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_admin, :current_user

  def current_user
    @current_user ||= RegisteredUser.find(session[:registered_user_id]) if session[:registered_user_id]
  end

  def require_login
    unless current_user
      redirect_to login_path
    end
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def find_user_by_username(username)
    pinspiration_credential = PinspirationCredential.find_by(username: username)
    if pinspiration_credential.present?
      pinspiration_credential.registered_user
    else
      google_credential = GoogleCredential.find_by(username: username)
      google_credential.registered_user
    end
  end

end

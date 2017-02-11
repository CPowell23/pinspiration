class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_admin, :current_user

  def current_user
    @current_user ||= RegisteredUser.find(session[:registered_user_id]) if session[:registered_user_id]
  end
  
  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end
end

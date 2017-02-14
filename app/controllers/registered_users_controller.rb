class RegisteredUsersController < ApplicationController
  include MessageHelper
  
  def show
    @user = find_user_by_username(params[:username])
    @boards = @user.boards
  end

  def edit
    user = find_user_by_username(params[:username])
    if user.pinspiration_credentials && user == current_user || current_admin
      @credentials = user.pinspiration_credentials.first
    else 
      redirect_to root_path
    end
  end
  
  def deactivate
    user = find_user_by_username(params[:username]) 
    if current_admin
      user.update(status: 'offline')
      flash_message_account_deactivated
      redirect_to edit_registered_user_path(user.username) 
    elsif current_user == user 
      user.update(status: 'offline')
      session[:registered_user_id] = nil
      flash_message_account_deactivated
      redirect_to login_path
    else
      redirect_to registered_user_path(user.username)
    end
  end


end

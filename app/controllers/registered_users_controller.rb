class RegisteredUsersController < ApplicationController
  def show
    @user = find_user_by_username(params[:username])
    @boards = @user.boards
  end

  def edit
    @user = find_user_by_username(params[:username])
  end
  
  def deactivate
    user = find_user_by_username(params[:username]) 
    if current_user == user || current_admin
      user.update(status: 'offline')
      session[:registered_user_id] = nil
      binding.pry
      redirect_to login_path
    else
      redirect_to registered_user_path(user.username)
    end
  end


end

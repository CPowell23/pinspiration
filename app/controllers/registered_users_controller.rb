class RegisteredUsersController < ApplicationController
  def show
    @user = find_user_by_username(params[:username])
    @boards = @user.boards
  end
end

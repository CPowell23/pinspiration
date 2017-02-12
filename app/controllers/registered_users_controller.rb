class RegisteredUsersController < ApplicationController
  def show
    @user = find_user_by_username_in_url(params[:username])
    @boards = @user.boards
  end
end

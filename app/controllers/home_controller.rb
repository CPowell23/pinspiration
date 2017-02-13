class HomeController < ApplicationController
  def index
    if current_user
      @user = RegisteredUser.find(current_user.id)
      @followings = @user.followings
    else
      redirect_to login_path
    end
  end
end

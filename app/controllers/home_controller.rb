class HomeController < ApplicationController
  def index
    if current_user
      @user = RegisteredUser.find(current_user.id)
    else
      redirect_to login_path
    end
  end
end
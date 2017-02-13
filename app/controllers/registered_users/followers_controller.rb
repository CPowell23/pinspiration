class RegisteredUsers::FollowersController < ApplicationController
  def index
    @user = find_user_by_username_in_url(params[:username])
    @followers = @user.followers
  end
end

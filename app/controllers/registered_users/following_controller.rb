class RegisteredUsers::FollowingController < ApplicationController
  include MessageHelper

  def index
    @user = find_user_by_username_in_url(params[:username])
    @following = @user.followings
  end

  def create
    user_doing_the_following = find_user_by_username_in_url(params[:username])
    user_being_followed = find_user_by_username_in_url(params[:username_of_user_being_followed])
    @following_join = FollowJoin.new(registered_user_id: user_being_followed.id,
                                      follower_id: user_doing_the_following.id)
    if @following_join.save
      flash_message_successful_following_creation
      redirect_to registered_user_path(user_being_followed.username)
    else
      @errors = @following_join.errors
      redirect_to registered_user_path(user_being_followed.username)
    end
  end

  def destroy
    user_doing_the_following = find_user_by_username_in_url(params[:username])
    user_being_followed = find_user_by_username_in_url(params[:username_of_user_being_followed])
    @following_join = user_doing_the_following.following_joins.find_by(registered_user_id: user_being_followed.id)
    @following_join.destroy

    flash_message_successful_following_delete
    if params[:option] == "from_user_show_page"
      redirect_to registered_user_path(user_being_followed.username)
    else
      redirect_to registered_users_following_path(params[:username])
    end
  end
end

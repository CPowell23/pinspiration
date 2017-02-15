class HomeController < ApplicationController
  before_action :require_login

  def index
    if current_user && current_user.followings.count != 0
      user = RegisteredUser.find(current_user.id)
      @activity = Pin.joins(registered_user: :followers).where(:follow_joins => {follower_id: user.id}).sort_by_most_recent
    else
      @activity = Pin.order("RANDOM()").first(20)
    end
  end
end

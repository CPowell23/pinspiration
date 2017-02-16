class Admin::DashboardController < Admin::BaseController
  def index
    @board_count = Board.count
    @user_count = RegisteredUser.count
    @pin_count = Pin.count
    @most_popular_user = RegisteredUser.most_followed_user
  end
end

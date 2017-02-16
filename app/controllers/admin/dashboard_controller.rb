class Admin::DashboardController < Admin::BaseController
  def index
    @board_count = Board.count
    @user_count = RegisteredUser.count
    @pin_count = Pin.count
  end
end

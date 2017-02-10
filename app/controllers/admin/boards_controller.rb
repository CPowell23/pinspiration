class Admin::BoardsController < Admin::BaseController
  include MessageHelper

  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    flash_message_successful_board_delete
    redirect_to registered_users_boards_path(@board.registered_user.username)
  end
end

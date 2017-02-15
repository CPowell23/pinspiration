class RegisteredUsers::LikeController < ApplicationController

  def create
    user = find_by_username(params[:username])
    board = user.boards.find_by(name: params[:name])
    Like.create(target: board, registered_user: current_user)
    redirect_to registered_users_board_path(user.username, board.name)
  end

  def destroy
    user = find_by_username(params[:username])
    board = user.boards.find_by(name: params[:name])
    like = board.likes.find(params[:id])
    like.destroy
    redirect_to registered_users_board_path(user.username, board.name)
  end

  private
    def find_by_username(username)
      if GoogleCredential.find_by(username: username)
        credentials = GoogleCredential.find_by(username: username)
      else
        credentials = PinspirationCredential.find_by(username: username)
      end
      credentials.registered_user
    end
end

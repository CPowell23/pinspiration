class RegisteredUsers::BoardsController < ApplicationController

  def index
    @user = find_by_username(params[:username])
    @boards = @user.boards
  end

  def show
    @board_presenter = BoardPresenter.new(params[:username], params[:name])
  end

  def edit
    @board = find_board
  end

  private

  def find_board
    PinspirationCredential
    .find_by(username: params[:username])
    .registered_user.boards
    .find_by(name: params[:name])
  end

  def find_by_username(username)
    if GoogleCredential.find_by(username: username)
      credentials = GoogleCredential.find_by(username)
    else
      credentials = PinspirationCredential.find_by(username: username)
    end
    credentials.registered_user
  end
end

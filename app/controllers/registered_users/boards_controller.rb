class RegisteredUsers::BoardsController < ApplicationController

  def index
    @boards = PinspirationCredential.find_by(username: params[:username]).registered_user.boards
  end

  def show
    @username = params[:username]
    @board = find_board
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

end

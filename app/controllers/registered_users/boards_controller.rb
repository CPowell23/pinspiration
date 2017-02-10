class RegisteredUsers::BoardsController < ApplicationController

  def index
    @user = find_by_username(params[:username])
    @boards = @user.boards
  end

  def show
    @board_presenter = BoardPresenter.new(params[:username], params[:name])
  end

  def edit
    @board_presenter = BoardPresenter.new(params[:username], params[:name])
    @categories = Category.all
  end

  def update
    @board_presenter = BoardPresenter.new(params[:username], params[:name])
    category = Category.find(params[:board][:category])
    @board_presenter.board.update_attributes(board_params[:board])
    redirect_to registered_users_board_path(params[:username], @board_presenter.board.name)
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

  def board_params
    params.permit(board: [:name, :description, :private])
  end
end

class RegisteredUsers::BoardsController < ApplicationController
  include MessageHelper

  def index
    @user = find_by_username(params[:username])
    @boards = @user.boards
  end

  def show
    @board_presenter = BoardPresenter.new(params[:username], params[:name])
  end

  def new
    @user = find_by_username(params[:username])
    @board = @user.boards.new()
    @categories = Category.all
  end

  def create
    board = Board.new(board_params)
    if board.save
      redirect_to registered_users_board_path(params[:username], board.name)
    else
      flash_message_failed_board_create
      @errors = board.errors
      render :new
    end
  end

  def edit
    @user = find_by_username(params[:username])
    if current_user == @user
      @board = @user.boards.find_by(name: params[:name])
      @categories = Category.all
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def update
    @board = find_board
    @categories = Category.all
    if @board.update_attributes(board_params)
      @board.save
      flash_message_successful_board_edit
      redirect_to registered_users_board_path(params[:username], @board.name)
    else
      flash_message_failed_board_edit
      @errors = @board.errors
      render :edit
    end
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
    params.require(:board).permit(:name, :description, :private)
  end
end

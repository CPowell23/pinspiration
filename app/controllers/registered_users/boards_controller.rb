class RegisteredUsers::BoardsController < ApplicationController
  include MessageHelper

  before_action :get_categories, only: [:new, :edit, :update]
  before_action :get_user, only: [:index, :new, :edit, :update]
  before_action :get_private_content, only: [:index]

  def index
  end

  def show
    @board_presenter = BoardPresenter.new(params[:username], params[:name])
  end

  def new
    if current_user
      @board = @user.boards.new()
    elsif current_admin
      redirect_to :status => 404
    else 
      redirect_to :status => 404
    end
  end

  def create
      board = current_user.boards.new(board_params)
      board.category = Category.find(params[:board][:category].to_i) if params[:board][:category] != ''
      if board_params[:private] == nil || board_params[:private] == 'public'
        board[:private] = false
      end
      if board.save
        redirect_to registered_users_board_path(params[:username], board.name)
      else
        flash_message_failed_board_create
        @errors = board.errors
        render :new
      end
  end

  def edit
    if current_user == @user
      @board = @user.boards.find_by(name: params[:name])
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def update
    @board = @user.boards.find_by(name: params[:name])
    if board_params[:private] == nil
      @board[:private] = false
    end
    if @board && @board.update_attributes(board_params)
      @board.save
      flash_message_successful_board_edit
      redirect_to registered_users_board_path(params[:username], @board.name)
    else
      flash_message_failed_board_edit
      @errors = @board.errors
      render :edit
    end
  end

  def destroy
    @board = Board.find_by(name: params[:name])
    @board.destroy

    flash_message_successful_board_delete
    redirect_to registered_users_boards_path(@board.registered_user.username)
  end

  private

    def get_user
      @user = find_by_username(params[:username])
      if @user.status == 'offline'
        flash_message_user_deactivated
        redirect_to root_path
      end 
    end

    def get_private_content
      if current_user && current_user.username == params[:username] 
        @boards = @user.boards.all
      else
        @boards = @user.boards.where(private: false)
      end
    end

    def get_categories
      @categories = Category.all
    end

    def find_board
      PinspirationCredential
      .find_by(username: params[:username])
      .registered_user.boards
      .find_by(name: params[:name])
    end

    def find_by_username(username)
      if GoogleCredential.find_by(username: username)
        credentials = GoogleCredential.find_by(username: username)
      else
        credentials = PinspirationCredential.find_by(username: username)
      end
      credentials.registered_user
    end

    def board_params
      params.require(:board).permit(:name, :description, :private)
    end
end

class RegisteredUsers::BoardsController < ApplicationController

  def index
    @user = find_by_username(params[:username])
    @boards = @user.boards
  end

  def show
    @board_presenter = BoardPresenter.new(params[:username], params[:name])
  end

  private
    def find_by_username(username)
      if GoogleCredential.find_by(username: username)
        credentials = GoogleCredential.find_by(username)
      else
        credentials = PinspirationCredential.find_by(username: username)
      end
      credentials.registered_user
    end
end

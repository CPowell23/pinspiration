class RegisteredUsers::BoardsController < ApplicationController

  def index
    @boards = PinspirationCredential.find_by(username: params[:username]).registered_user.boards
  end

end

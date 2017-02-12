class BoardPresenter
  attr_reader :user, :board, :pins

  def initialize(username, board_name)
    @user = PinspirationCredential.find_by(username: username).registered_user
    @board = @user.boards.find_by(name: board_name)
    @pins = @board.pins
  end

end

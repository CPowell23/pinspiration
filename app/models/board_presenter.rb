class BoardPresenter
  attr_reader :user, :board, :pins

  def initialize(username, board_name)
    @user = find_user(username)
    @board = @user.boards.find_by(name: board_name)
    @pins = @board.pins
  end

  def find_user(username)
    credentials = PinspirationCredential.find_by(username: username)
    if credentials 
      @user = credentials.registered_user
    else
      @user = GoogleCredential.find_by(username: username).registered_user
    end
  end
end

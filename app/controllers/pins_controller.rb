class PinsController < ApplicationController
  include MessageHelper

  def index
    @user = find_user_by_username(params[:username])
    @pins = @user.pins
  end

  def show
    @pin = Pin.find(params[:id])
  end

  def new
    @boards = current_user.boards
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    if @pin.save
      flash_message_successful_pin_creation
      redirect_to pin_path(@pin)
    else
      @errors = @pin.errors
      render :new
    end
  end

  private

    def find_user_by_username(username)
      if GoogleCredential.find_by(username: username)
        credentials = GoogleCredential.find_by(username)
      else
        credentials = PinspirationCredential.find_by(username: username)
      end
      credentials.registered_user
    end

    def pin_params
      params.require(:pin).permit(:description, :image_url, :article_url, :board_id)
    end
end

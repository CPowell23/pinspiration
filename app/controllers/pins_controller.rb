class PinsController < ApplicationController
  include MessageHelper


  def show
    @pin = Pin.find(params[:id])
  end

  def new
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

  def edit
    @boards = current_user.boards
    @pin = Pin.find(params[:id])
  end

  def update
    @pin = Pin.find(params[:id])
    if @pin.update(pin_params)
      flash_message_successful_pin_edit
      redirect_to pin_path(@pin)
    else
      flash_message_failed_pin_edit
      @errors = @pin.errors
      render :edit
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy

    flash_message_successful_pin_delete
    redirect_to registered_users_pins_path(current_user.username)
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

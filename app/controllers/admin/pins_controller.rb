class Admin::PinsController < Admin::BaseController
  include MessageHelper

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy

    flash_message_successful_pin_delete
    redirect_to pins_index_path(@pin.registered_user.username)
  end
end

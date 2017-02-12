class LikeController < ApplicationController

  def create
    if params[:pin_id]
      pin = Pin.find(params[:pin_id])
      Like.create(target: pin, registered_user: current_user) 
      redirect_to pin_path(pin)
    elsif params[:board_id]
      Like.create()
    else
      Like.create()
    end
  end
  
  def destroy
    pin = Pin.find(params[:pin_id])
    like = Like.find(params[:id])
    like.destroy
    redirect_to pin_path(pin)
  end

end

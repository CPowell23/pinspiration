class Pins::CommentsLikeController < ApplicationController

  def create
    pin = Pin.find(params[:pin_id])
    comment = Comment.find(params[:comment_id])
    Like.create(target: comment, registered_user: current_user)
    redirect_to pin_path(pin)
  end

  def destroy
    pin = Pin.find(params[:pin_id])
    comment = Comment.find(params[:comment_id])
    like = Like.find(params[:id])
    like.destroy
    redirect_to pin_path(pin)
  end

end

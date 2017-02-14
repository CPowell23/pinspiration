class Api::V1::Pins::CommentsController < ApplicationController

  def index
    render json: Pin.find(params[:id]).comments
  end

  def show
    # byebug
    render json: Pin.find(params[:id]).comments.find(params[:comment_id])
  end

  def destroy
    comment = Pin.find(params[:id]).comments.find(params[:comment_id])
    comment.destroy
  end
end

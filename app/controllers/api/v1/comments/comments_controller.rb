class Api::V1::Comments::CommentsController < ApplicationController

  def index
    render json: Pin.find(params[:id]).comments
  end
end

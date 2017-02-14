class Api::V1::Pins::CommentsController < Api::V1::BaseController
  def index
    render json: Pin.find(params[:id]).comments
  end

  def show
    render json: Pin.find(params[:id]).comments.find(params[:comment_id])
  end

  def destroy
    comment = Pin.find(params[:id]).comments.find(params[:comment_id])
    comment.destroy
  end

  def create
    pin = Pin.find(params[:id])
    comment = pin.comments.new(comment_params)
    if !comment.save
    else
      comment.save
    end
  end

  def update
    pin = Pin.find(params[:id])
    comment = pin.comments.find(params[:comment_id])
    if !comment.update_attributes(comment_params)
    else
      comment.update_attributes(comment_params)
    end
  end

  private

  def comment_params
    params.permit(:pin_id, :registered_user_id, :content)
  end
end

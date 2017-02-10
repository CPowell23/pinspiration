class Pins::CommentsController < ApplicationController
  include MessageHelper

  def new
    @pin = Pin.find(params[:pin_id])
    @previous_comments = @pin.comments.sort_by_most_recent
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash_message_successful_comment_creation
      redirect_to new_pin_comment_path(@comment.pin)
    else
      @errors = @comment.errors
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    flash_message_successful_comment_delete
    redirect_to new_pin_comment_path(@comment.pin)
  end

  private

    def comment_form_params
      params.require(:comment).permit(:content)
    end

    def comment_params
      comment_params = {}
      comment_params[:content] = comment_form_params[:content]
      comment_params[:registered_user_id] = current_user.id
      comment_params[:pin_id] = params[:pin_id]
      comment_params
    end
end

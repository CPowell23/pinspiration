class Admin::CommentsController < Admin::BaseController
  include MessageHelper

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    flash_message_successful_comment_delete
    redirect_to new_pin_comment_path(@comment.pin)
  end
end

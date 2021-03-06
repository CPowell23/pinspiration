module MessageHelper

  def flash_message_successful_login
    flash[:success] = "Successfully logged in"
  end

  def flash_message_successful_logout
    flash[:dark_background] = "Successfully logged out"
  end

  def flash_message_failed_login
    flash.now[:dark_background] = "Email and password combination does not exist"
  end

  def flash_message_successful_account_creation
    flash[:success] = "Successfully logged in with new account"
  end

  def flash_message_successful_pin_creation
    flash[:success] = "Successfully created pin"
  end

  def flash_message_successful_pin_edit
    flash[:success] = "Successfully edited pin"
  end

  def flash_message_failed_pin_edit
    flash[:danger] = "Failed to edit pin. Please fix errors and try again."
  end

  def flash_message_successful_pin_delete
    flash[:success] = "Successfully deleted pin"
  end

  def flash_message_failed_board_edit
    flash[:danger] = "Failed to edit board. Please fix errors and try again."
  end

  def flash_message_failed_board_create
    flash[:danger] = "Failed to create board. Please fix errors and try again."
  end

  def flash_message_successful_board_edit
    flash[:success] = "Successfully updated board"
  end

  def flash_message_successful_comment_creation
    flash[:success] = "Thank you for your comment!"
  end

  def flash_message_successful_comment_delete
    flash[:success] = "Your comment was deleted"
  end

  def flash_message_successful_board_delete
    flash[:success] = "Successfully deleted board"
  end

  def flash_message_successful_following_creation
    flash[:success] = "You are now following this user"
  end

  def flash_message_successful_following_delete
    flash[:success] = "You are no longer following this user"
  end

  def flash_message_account_deleted
    flash[:success] = "Account successfully deleted"
  end

  def flash_message_account_deactivated
    flash[:success] = "Account successfully deactivated"
  end

  def flash_message_user_deactivated
    flash[:danger] = "This user's account has been deactivated. Sorry."
  end
  
  def flash_message_account_reactivated
    flash[:success] = "Account successfully reactivated"
  end
  
  def flash_message_successful_account_update
    flash[:success] = "Account successfully updated"
  end

  def flash_message_failed_account_update
    flash[:danger] ="Account update failed. Please check you filled in all required fields"
  end
end

module MessageHelper

  def flash_message_successful_login
    flash[:success] = "Successfully logged in"
  end

  def flash_message_successful_logout
    flash[:success] = "Successfully logged out"
  end

  def flash_message_failed_login
    flash[:danger] = "Email and password combination does not exist"
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

  def flash_message_successful_comment_creation
    flash[:success] = "Thank you for your comment!"
  end

  def flash_message_successful_comment_delete
    flash[:success] = "Your comment was deleted"
  end

end

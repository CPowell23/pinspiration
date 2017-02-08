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

end
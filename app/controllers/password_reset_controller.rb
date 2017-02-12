class PasswordResetController < ApplicationController
  def index
  end

  def show
    @user = find_by_username(params[:search])
  end

  def create
    # @user = User.find_by(email: params[:password_reset][:email].downcase)
    @user.send_password_reset_sms
    flash[:info] = "SMS sent with password reset instructions"
    redirect_to root_url
  end

  private

    def find_by_username(username)
      if GoogleCredential.find_by(username: username)
        credentials = GoogleCredential.find_by(username: username)
      else
        credentials = PinspirationCredential.find_by(username: username)
      end
      credentials.registered_user
    end

end

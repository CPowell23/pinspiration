class PasswordResetsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    user = find_by_username(params[:password_reset][:username])
    phone_number = user.pinspiration_credentials.first.phone_number

    RegisteredUser.send_password_reset_sms(phone_number)
    flash[:info] = "SMS sent with password reset instructions"
    redirect_to root_url
  end

  def update
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

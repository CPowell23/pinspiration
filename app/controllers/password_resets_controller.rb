class PasswordResetsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @user = find_by_username(params[:password_reset][:username])
    if @user
      phone_number = @user.pinspiration_credentials.first.phone_number
      reset_pin    = @user.pinspiration_credentials.first.otp_code

      RegisteredUser.send_password_reset_sms(phone_number,reset_pin)
      redirect_to password_confirmation_path
    else
      flash.now[:danger] = "username not found"
      render 'new'
    end
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

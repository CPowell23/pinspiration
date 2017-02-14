class PasswordResetsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
    @credential = PinspirationCredential.find_by(email: params[:email])
  end

  # def create
  #   @credential = PinspirationCredential.find_by(email: params[:email])
  #   if @credential
  #     phone_number = @credential.phone_number
  #     reset_pin    = @credential.otp_code
  #
  #     RegisteredUser.send_password_reset_sms(phone_number,reset_pin)
  #     redirect_to reset_index_path, :notice => "SMS sent!"
  #   else
  #     flash.now[:danger] = "email not found"
  #     render 'new'
  #   end
  # end

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

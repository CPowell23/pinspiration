class PasswordsController < ApplicationController
  def new
  end

  def verify
    @credential = PinspirationCredential.find_by(email: params[:email])
    if @credential
      phone_number = @credential.phone_number
      reset_pin    = @credential.otp_code

      send_password_reset_sms(phone_number,reset_pin)
      flash[:notice] = "SMS sent!"
    else
      flash[:alert] = "Email address not found. Please try again."
      redirect_to password_reset_path
    end
  end

  def verify_confirm
    @credential = PinspirationCredential.find_by(email: params[:email])
    if @credential.authenticate_otp(params[:pin])
      @credential.update(password: params[:password])
      redirect_to root_path, :notice => "Pin verified! Your password has been reset."
    else
      flash.now[:danger] = "Incorrect Pin."
      render 'verify'
    end
  end

  private

  def send_password_reset_sms(phone_number,reset_pin)
    TwilioService.new(phone_number,reset_pin).send_sms
  end

end

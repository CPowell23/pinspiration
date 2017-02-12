require 'twilio-ruby'

class TwilioService

  def initialize(phone_number,reset_pin)
    @reset_pin = reset_pin
    @phone_number = phone_number
  end

  def send_sms
    account_sid = "AC9f920c6d975606e473d8d5155e05931c"
    auth_token = "1d5940e6578e7304e03aa015976f7c6d"

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.account.messages.create(
        :body => "Pinspiration Password Reset Pin: #{@reset_pin}",
        :to => @phone_number,
        :from => "+17207091846")
  end

end

require 'twilio-ruby'

class TwilioService

  def initialize(phone_number,reset_pin)
    @reset_pin = reset_pin
    @phone_number = phone_number
  end

  def send_sms
    account_sid = "AC9f920c6d975606e473d8d5155e05931c" # Your Account SID from www.twilio.com/console
    auth_token = "1d5940e6578e7304e03aa015976f7c6d"   # Your Auth Token from www.twilio.com/console

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.account.messages.create(
        :body => "Pinspiration Password Reset Pin: #{@reset_pin}",
        :to => @phone_number,    # Replace with your phone number
        :from => "+17207091846")  # Replace with your Twilio number
  end

end

# TwilioService.new("+13038834351","1234").send_sms

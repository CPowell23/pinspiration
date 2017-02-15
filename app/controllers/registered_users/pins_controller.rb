class RegisteredUsers::PinsController < ApplicationController

  def index
    @user = find_user_by_username(params[:username])
    @pins = @user.pins
  end

  private

    def find_user_by_username(username)
      if GoogleCredential.find_by(username: username)
        credentials = GoogleCredential.find_by(username: username)
      else
        credentials = PinspirationCredential.find_by(username: username)
      end
      credentials.registered_user
    end
end

class RegisteredUsersController < ApplicationController
  def show
    pinspiration_credential = PinspirationCredential.find_by(username: params[:username])
    if pinspiration_credential
      @user = pinspiration_credential.registered_user
    else
      google_credential = GoogleCredential.find_by(username: params[:username])
      @user = google_credential.registered_user
    end
    @boards = @user.boards
  end
end

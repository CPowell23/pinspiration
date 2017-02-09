class SessionsController < ApplicationController
  def create
    @registered_user = RegisteredUser.create(status: 1)
    @credential = @registered_user.pinspiration_credentials.create(credential_params)
    
    if @credential.save
      session[:user_id] = @credential.registered_user.id
      redirect_to '#'
    else
      redirect_to root_path
    end

    # user          = RegisteredUser.find_or_create_by(email: )
    # user.username = auth["login"]
    # user.uid      = auth["id"]
    # user.token    = token
    # user.save
    # session[:user_id] = user.id
  end

  private
    def credential_params
      params.require(:pinspiration_credential).permit(:name, :username, :email, :password, :phone_number)
    end
end
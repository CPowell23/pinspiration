class SessionsController < ApplicationController
  def create
    @registered_user = RegisteredUser.create(status: 1)
    if params.include?("pinspiration")
      @credential = @registered_user.pinspiration_credentials.create(credential_params)
    elsif params.include?("code")
      @credential = @registered_user.google_credentials.create(google_credential_params)
    end

    if @credential.save
      session[:user_id] = @credential.registered_user.id
      redirect_to '#'
    else
      redirect_to root_path
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def credential_params
      params.require(:pinspiration_credential).permit(:name, :username, :email, :password, :phone_number)
    end

    def google_credential_params
      params.require(:google_credential).permit(:name, :google_id)
    end
end

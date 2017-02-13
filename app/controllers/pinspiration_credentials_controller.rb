class PinspirationCredentialsController < ApplicationController
  include MessageHelper

  def new
    @pinspiration_credential = PinspirationCredential.new
  end

  def create
    # move this to a user create PORO instead of putting it in the controller
    # ActiveRecord::Base.transaction do
      @registered_user = RegisteredUser.create(status: "online")
      @credential = @registered_user.pinspiration_credentials.create(credential_params)

      if @credential.save
        session[:registered_user_id] = @credential.registered_user.id
        flash_message_successful_account_creation
        redirect_to root_path
      else
        @registered_user.destroy
        @credential.destroy
        @errors = @credential.errors
        render :new
      end
    # end
  end

  private
    def credential_params
      params.require(:pinspiration_credential).permit(:name, :username, :email, :password, :password_confirmation, :phone_number, :image_url)
    end
end

class Admin::SessionsController < Admin::BaseController
  include MessageHelper
  skip_before_action :require_admin, only: [:new, :create]

  def new
  end

  def create
    if authenticated_admin?
      session[:admin_id] = admin.id
      flash_message_successful_login
      redirect_to admin_dashboard_path
    else
      flash_message_failed_login
      render :new
    end
  end

  # def destroy
  #   session[:admin_id] = nil
  #   flash_message_successful_logout
  #   redirect_to(admin_login_path)
  # end

  private

    def admin
      Admin.find_by(email: params[:email])
    end

    def authenticated_admin?
      admin && admin.authenticate(params[:password])
    end
end

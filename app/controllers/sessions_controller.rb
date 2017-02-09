class SessionsController < ApplicationController
  def create
    @registered_user = RegisteredUser.create(registered_user_params)
    # if @registered_user = RegisteredUser.find_by(params[:session][:id])
    # session[:registered_user_id] = 
    byebug
    user          = RegisteredUser.find_or_create_by(email: )
    user.username = auth["login"]
    user.uid      = auth["id"]
    user.token    = token
    user.save
    session[:user_id] = user.id
  end
end
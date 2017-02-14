class Api::V1::BaseController < ApplicationController
  before_action :authenticate_key

  private

    def authenticate_key
      key = params[:api_key]
      if !DeveloperCredential.find_by(api_key: key)
        # byebug
        render json: { errors: "Invalid key" }, status: 422
      end
    end
end

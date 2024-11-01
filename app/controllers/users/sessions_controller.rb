# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :configure_permitted_parameters

    # respond_to :json

    # def create

    #   binding.pry

    #   resource = warden.authenticate!(auth_options.merge(store: false, recall: "#{controller_path}#failure"))
    #   access_token = JsonWebToken.encode(user_id: resource.id)
    #   render json: {
    #     access_token: access_token
    #   }, status: :ok
    # end

    # def failure
    #   render json: { error: 'email_password_invalid' }, status: :unauthorized
    # end

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password) }
    end
  end
end

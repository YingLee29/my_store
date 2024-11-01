# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class TokenTimeoutError < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::TokenTimeoutError, with: :expired_token_request
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  private

  def unauthorized_request(error)
    render json: {
      error: error.message
    }, status: :unauthorized
  end

  def expired_token_request(_error)
    render json: {
      error: 'session_time_out',
      require_refresh: true
    }, status: :unauthorized
  end

  def not_found(error)
    render json: {
      error: error.message
    }, status: :not_found
  end
end

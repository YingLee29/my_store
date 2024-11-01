# frozen_string_literal: true

module Devise
  module Strategies
    class JwtStrategy < Base
      def valid?
        request.headers["Authorization"].present?
      end

      def authenticate!
        raise ExceptionHandler::AuthenticationError if no_payload_or_payload_user_id

        success! User.find_by(id: payload["user_id"], access_token: access_token)
      end

      private

      def access_token
        bearer_token = request.headers.fetch("Authorization", "").split
        return nil unless (bearer_token.first || "").casecmp("bearer").zero?
        bearer_token.last
      end

      def no_payload_or_payload_user_id
        !payload || !payload.key?("user_id")
      end

      def payload
        JsonWebToken.decode(access_token)
      rescue JWT::ExpiredSignature
        raise ExceptionHandler::TokenTimeoutError
      rescue StandardError
        nil
      end
    end
  end
end

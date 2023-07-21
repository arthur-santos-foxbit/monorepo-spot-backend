require 'active_support/concern'

module MonorepoAuth
  module AuthenticateConcern
    extend ActiveSupport::Concern

    class AuthenticationError < StandardError; end

    included do
      rescue_from AuthenticationError do |exception|
        render(json: { error: exception.message }, status: 401)
      end

      def dentity_cid
        @dentity_cid
      end

      private

      def authenticate!
        service_response = MonorepoAuth::Authenticate.new(
          token: request.headers['Authorization'],
          algorithm: ENV.fetch('AUTH_ALGORITHM', JWT_DEFAULT_ALGORITHM),
          secret: ENV.fetch('AUTH_SECRET'),
          ip: request.remote_ip
        ).call

        if service_response.success
          @dentity_cid = service_response.data[:email]
        else
          raise AuthenticationError, service_response.error_message
        end
      end
    end
  end
end

require 'santa_cruz/service_response'
require 'santa_cruz/service_error'
require 'jwt'

module MonorepoAuth
  class Authenticate
    def initialize(params)
      @token = params[:token]
      @secret = params[:secret]
      @algorithm = params[:algorithm]
      @ip = params[:ip]
    end

    def call
      define_timestamp
      decode_token
      load_cid
      verify_ip

      raise SantaCruz::ServiceError, 'expired token' if @token_payload['exp'] < @timestamp

      SantaCruz::ServiceResponse.new(success: true, data: { cid: @cid })
    rescue SantaCruz::ServiceError => e
      SantaCruz::ServiceResponse.new(success: false, error: e)
    end

    private

    def decode_token
      raise SantaCruz::ServiceError, 'missing token' if @token.blank?
      raise SantaCruz::ServiceError, 'missing secret' if @secret.blank?
      raise SantaCruz::ServiceError, 'missing algorithm' if @algorithm.blank?

      decoded_token = JWT.decode @token, @secret, true, { algorithm: @algorithm }

      @token_payload = decoded_token.first
      @token_header = decoded_token.last
    rescue JWT::DecodeError => e
      raise SantaCruz::ServiceError.new('invalid token', genesis_error: e)
    end

    def define_timestamp
      @timestamp = Time.now.to_i
    end

    def load_cid
      @cid = @token_payload['cid']

      raise SantaCruz::ServiceError, 'invalid cid' if @cid.blank?
    end

    def verify_ip
      raise SantaCruz::ServiceError, 'missing ip' if @ip.blank?
      raise SantaCruz::ServiceError, 'invalid ip' unless @ip == @token_payload['ip']
    end
  end
end

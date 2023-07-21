# require 'bcrypt'
require 'digest'

class SignupService < SantaCruz::ApplicationService
  include EncryptionHelper

  def initialize(params)
    super()
    @email = params[:email]
    @cid = params[:cid]
    @password = params[:password]
  end

  def call
    encrypt_password

    identity = Identity.new(
      email: @email,
      cid: @cid,
      encrypted_password: @encrypted_password
    )

    identity.save!
    build_response(data: { identity: })
  rescue ActiveRecord::RecordInvalid => e
    build_response(success: false, error: SantaCruz::ServiceError.new(e.message, genesis_error: e))
  end

  private

  # def encrypt_password
  #   @encrypted_password = BCrypt::Password.create(@password)
  # end

  def encrypt_password
    @encrypted_password = string_to_sha256(@password)
  end
end

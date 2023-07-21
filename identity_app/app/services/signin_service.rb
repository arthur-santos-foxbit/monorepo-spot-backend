class SigninService < SantaCruz::ApplicationService
  SECRET = ENV['AUTH_SECRET']
  ALGORITHM = ENV['AUTH_ALGORITHM']
  EXPIRATION = ENV['SANTA_CRUZ_AUTH_EXPIRATION']

  def initialize(params)
    super()
    @email = params[:email]
    @password = params[:password]
  end

  def call
    load_identity
    verify_password
    generate_token

    build_response(data: { token: @token })
  rescue SantaCruz::ServiceError => e
    build_response(success: false, error: e)
  end

  private

  def load_identity
    @identity = Identity.find_by_email!(@email)
  rescue ActiveRecord::RecordNotFound => e
    raise SantaCruz::ServiceError.new('invalid email', genesis_error: e)
  end

  def generate_token
    monorepo_auth_response = MonorepoAuth::GenerateToken.new(
      email: @identity.email,
      secret: SECRET,
      algorithm: ALGORITHM,
      expiration: EXPIRATION
    ).call

    if monorepo_auth_response.success
      @token = monorepo_auth_response.data[:token]
    else
      raise monorepo_auth_response.error
    end
  end

  def verify_password
    return if BCrypt::Password.new(@identity.encrypted_password) == @password

    raise SantaCruz::ServiceError, 'invalid password'
  end
end

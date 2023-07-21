require 'monorepo_auth/identity_info'
require 'monorepo_auth/generate_token'
require 'monorepo_auth/authenticate'
require 'monorepo_auth/authenticate_concern'

module MonorepoAuth
  JWT_DEFAULT_ALGORITHM = 'HS256'.freeze
  JWT_DEFAULT_EXPIRATION = 3600
end

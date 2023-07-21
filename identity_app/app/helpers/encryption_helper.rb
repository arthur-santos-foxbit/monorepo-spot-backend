module EncryptionHelper
  def string_to_sha256(str)
    Digest::SHA256.hexdigest(str)
  end
end

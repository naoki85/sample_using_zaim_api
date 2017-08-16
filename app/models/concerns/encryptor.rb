module Encryptor
  CIPHER = "aes-256-cbc"
  def encrypt(param)
    secure = ENV['ENCRYPT_SECURE_KEY']
    crypt = ActiveSupport::MessageEncryptor.new(secure, CIPHER)
    crypt.encrypt_and_sign(param)
  end

  def decrypt(param)
    secure = ENV['ENCRYPT_SECURE_KEY']
    crypt = ActiveSupport::MessageEncryptor.new(secure, CIPHER)
    crypt.decrypt_and_verify(param)
  end
end
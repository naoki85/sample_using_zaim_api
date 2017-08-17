class User < ApplicationRecord
  include Encryptor

  has_many :tweet_messages

  # Find or create by auth hash
  # @param  [String] auth_hash
  # @return [Object] user
  def self.find_or_create_from_auth_hash(auth_hash)
    provider  = auth_hash[:provider]
    uid       = auth_hash[:uid]
    nickname  = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname  = nickname
      user.image_url = image_url
    end
  end

  ## Setter & Getter##
  ## Twitter ##

  def twitter_consumer_key=(value)
    self.encrypt_tw_consumer_key = encrypt(value)
  end

  def twitter_consumer_key
    return '' if self.encrypt_tw_consumer_key.nil?
    decrypt(self.encrypt_tw_consumer_key)
  end

  def twitter_consumer_secret=(value)
    self.encrypt_tw_consumer_secret = encrypt(value)
  end

  def twitter_consumer_secret
    return '' if self.encrypt_tw_consumer_secret.nil?
    decrypt(self.encrypt_tw_consumer_secret)
  end

  def twitter_access_token=(value)
    self.encrypt_tw_access_token = encrypt(value)
  end

  def twitter_access_token
    return '' if self.encrypt_tw_access_token.nil?
    decrypt(encrypt_tw_access_token)
  end

  def twitter_access_token_secret=(value)
    self.encrypt_tw_access_token_secret = encrypt(value)
  end

  def twitter_access_token_secret
    return '' if self.encrypt_tw_access_token_secret.nil?
    decrypt(encrypt_tw_access_token_secret)
  end

  ## Zaim ##

  def zaim_request_token=(value)
    self.encrypt_zaim_request_token = encrypt(value)
  end

  def zaim_request_token
    return '' if self.encrypt_zaim_request_token.nil?
    decrypt(self.encrypt_zaim_request_token)
  end

  def zaim_request_token_secret=(value)
    self.encrypt_zaim_request_token_secret = encrypt(value)
  end

  def zaim_request_token_secret
    return '' if self.encrypt_zaim_request_token_secret.nil?
    decrypt(self.encrypt_zaim_request_token_secret)
  end

  def zaim_access_token=(value)
    self.encrypt_zaim_access_token = encrypt(value)
  end

  def zaim_access_token
    return '' if self.encrypt_zaim_access_token.nil?
    decrypt(encrypt_zaim_access_token)
  end

  def zaim_access_token_secret=(value)
    self.encrypt_zaim_access_token_secret = encrypt(value)
  end

  def zaim_access_token_secret
    return '' if self.encrypt_zaim_access_token_secret.nil?
    decrypt(encrypt_zaim_access_token_secret)
  end
end

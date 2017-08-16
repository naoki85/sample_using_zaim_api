class User < ApplicationRecord
  include Encryptor

  attr_accessor :decrypt_twitter_consumer_key,
                :decrypt_twitter_consumer_secret,
                :decrypt_twitter_access_token,
                :decrypt_twitter_access_token_secret

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

  # Update below parameters
  # @param  [String] params['twitter_consumer_key']
  # @param  [String] params['twitter_consumer_secret']
  # @param  [String] params['twitter_access_token']
  # @param  [String] params['twitter_access_token_secret']
  # @return [Object]
  def update_user_with_encrypt(params)
    update(encrypt_params(params))
  end

  def decrypt_twitter_consumer_key
    decrypt(self.twitter_consumer_key)
  end

  def decrypt_twitter_consumer_secret
    decrypt(self.twitter_consumer_secret)
  end

  def decrypt_twitter_access_token
    decrypt(self.twitter_access_token)
  end

  def decrypt_twitter_access_token_secret
    decrypt(self.twitter_access_token_secret)
  end

  private

  # Encrypt params
  # @param  [String] params['twitter_consumer_key']
  # @param  [String] params['twitter_consumer_secret']
  # @param  [String] params['twitter_access_token']
  # @param  [String] params['twitter_access_token_secret']
  # @return [Hash]
  def encrypt_params(params)
    ret_params = {}
    ret_params['twitter_consumer_key'] = encrypt(params['twitter_consumer_key'])
    ret_params['twitter_consumer_secret'] = encrypt(params['twitter_consumer_secret'])
    ret_params['twitter_access_token'] = encrypt(params['twitter_access_token'])
    ret_params['twitter_access_token_secret'] = encrypt(params['twitter_access_token_secret'])

    ret_params
  end
end

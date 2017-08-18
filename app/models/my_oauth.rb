require 'json'
require 'oauth'

class MyOauth
  CONSUMER_KEY     = ENV['ZAIM_CONSUMER_KEY']
  CONSUMER_SECRET  = ENV['ZAIM_CONSUMER_SECRET']

  attr_accessor :consumer, :request_token

  def initialize
    self.consumer = OAuth::Consumer.new(
        CONSUMER_KEY,
        CONSUMER_SECRET,
        site: 'https://api.zaim.net',
        request_token_path: '/v2/auth/request',
        authorize_url: 'https://auth.zaim.net/users/auth',
        access_token_path: '/v2/auth/access'
    )
  end

  # @param [String] request_token
  # @param [String] request_secret
  def set_request_token(request_token, request_secret)
    self.request_token = OAuth::RequestToken.new(
        self.consumer,
        request_token,
        request_secret
    )
  end

  # @param [Object] consumer
  # @param [String] access_token
  # @param [String] access_token_secret
  def set_access_token(access_token, access_token_secret)
    OAuth::AccessToken.new(
        self.consumer,
        access_token,
        access_token_secret
    )
  end
end
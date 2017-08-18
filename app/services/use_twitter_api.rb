require 'twitter'

class UseTwitterApi

  # @param [String] consumer_key
  # @param [String] consumer_secret
  # @param [String] access_token
  # @param [String] access_secret
  def initialize(consumer_key, consumer_secret, access_token, access_secret)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = consumer_key
      config.consumer_secret     = consumer_secret
      config.access_token        = access_token
      config.access_token_secret = access_secret
    end
  end

  # @param [String] message
  def tweet_message(message)
    begin
      @client.update(message)
    rescue => e
      retry
    end
  end
end
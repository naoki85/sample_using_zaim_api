require 'twitter'

class TwitterApi

  def initialize(consumer_key, consumer_secret, access_token, access_secret)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = consumer_key
      config.consumer_secret     = consumer_secret
      config.access_token        = access_token
      config.access_token_secret = access_secret
    end
  end

  def tweet_message(message)
    begin
      @client.update(message)
    rescue => e
      retry
    end
  end
end
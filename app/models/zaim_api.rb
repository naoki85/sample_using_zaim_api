require 'json'
require 'oauth'

class ZaimApi
  API_BASE_URL     = 'https://api.zaim.net/v2'

  def initialize(consumer, access_token, access_token_secret)
    @oauth_by_access_token = set_oauth_access_token(consumer, access_token, access_token_secret)
  end

  # GET /home/money
  # List user input
  def get_list_of_input_money_data
    money = @oauth_by_access_token.get("#{API_BASE_URL}/home/money")
    return JSON.parse(money.body)
  end

  private

  # @param [Object] consumer
  # @param [String] access_token
  # @param [String] access_token_secret
  def set_oauth_access_token(consumer, access_token, access_token_secret)
    OAuth::AccessToken.new(
        consumer,
        access_token,
        access_token_secret
    )
  end
end
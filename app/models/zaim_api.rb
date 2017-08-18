require 'json'
require 'oauth'

class ZaimApi
  API_BASE_URL     = 'https://api.zaim.net/v2'

  def initialize(consumer, access_token, access_token_secret)
    @oauth_by_access_token = set_oauth_access_token(consumer, access_token, access_token_secret)
  end

  # Sum of amount from API response
  # @param  [JSON]    response_data
  # @return [Integer]
  def self.sum_payment_amount(response_data)
    sum = 0
    response_data['money'].each do |data|
      sum += data['amount'].to_i
    end
    sum
  end

  # GET /home/money
  # List user input
  # @param  [Hash]
  # @return [JSON]
  def get_list_of_input_money_data(params)
    money = @oauth_by_access_token.get("#{API_BASE_URL}/home/money#{get_parameters_home_money(params)}")
    JSON.parse(money.body)
  end

  # GET /Category
  # List category and return params are hash key is ID and value is category name.
  # @return [Hash]
  def get_category_list
    categories = @oauth_by_access_token.get("#{API_BASE_URL}/category")
    json_categories = JSON.parse(categories.body)

    ret_hash = {}
    json_categories['categories'].each do |value|
      ret_hash[value['id']] = value['name']
    end
    ret_hash
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

  # GET parameters for API /home/money
  # params [Hash] params
  #   mapping: set 1
  #   category_id: narrow down by category_id
  #   genre_id: narrow down by genre_id
  #   mode: narrow down by type (payment or income or transfer)
  #   order: sort by id or date (default : date)
  #   start_date: the first date (Y-m-d format)
  #   end_date: the last date (Y-m-d format)
  #   page: number of current page (default 1)
  #   limit: number of items per page (default 20, max 100)
  #   group_by: if you set as "receipt_id", Zaim makes the response group by the receipt_id (option)
  # @return [String]
  def get_parameters_home_money(params)
    query_params = ''
    query_params << '?mapping=1'

    params.each do |key, param|
      if param.present?
        query_params << "&#{key}=#{param}"
      end
    end
    query_params
  end
end
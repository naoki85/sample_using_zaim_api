class UseZaimApi

  attr_accessor :zaim_api

  # @param [String] access_token
  # @param [String] access_token_secret
  def initialize(access_token, access_token_secret)
    access_token = MyOauth.new.set_access_token(access_token, access_token_secret)
    self.zaim_api = ZaimApi.new(access_token)
  end

  # List user input
  # @param  [Hash]
  # @return [JSON]
  def get_list_of_input_money_data(options)
    self.zaim_api.home_money(options)
  end

  # List category and return params are hash key is ID and value is category name.
  # @return [Hash]
  def get_category_list
    self.zaim_api.category
    json_categories = self.zaim_api.category

    ret_hash = {}
    json_categories['categories'].each do |value|
      ret_hash[value['id']] = value['name']
    end
    ret_hash
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
end
class ZaimApiController < ApplicationController
  include ZaimApiHelper

  CALLBACK_URL = ENV['ZAIM_CALLBACK_URL']

  def login
    my_oauth = MyOauth.new
    request_token = my_oauth.consumer.get_request_token(oauth_callback: CALLBACK_URL)
    session[:request_token] = request_token.token
    session[:request_secret] = request_token.secret
    redirect_to request_token.authorize_url(oauth_callback: CALLBACK_URL)
  end

  def callback
    if session[:request_token] && params[:oauth_verifier]
      my_oauth = MyOauth.new
      my_oauth.set_request_token(session[:request_token], session[:request_secret])

      oauth_verifier = params[:oauth_verifier]
      access_token = my_oauth.request_token.get_access_token(:oauth_verifier => oauth_verifier)
      session[:access_token] = access_token.token
      session[:access_secret] = access_token.secret

      if current_user.update(zaim_token_params)
        redirect_to root_path
      else
        logout
      end
    else
      logout
    end
  end

  def index
    unless_coordinated_redirect_to_root(current_user)

    use_zaim_api = UseZaimApi.new(
        current_user.zaim_access_token,
        current_user.zaim_access_token_secret)
    options = { start_date: Time.zone.now.prev_year, mode: 'payment' }
    money = use_zaim_api.get_list_of_input_money_data(current_user.id, options)
    @category = use_zaim_api.get_category_list

    @money, @sum = list_and_sum_of_payment_by_start_date(money, params[:start_date])
  end

  def index_re_acquisition
    Rails.cache.delete("zaim_api/home/money/#{current_user.id}")
    redirect_to zaim_money_path
  end

  private

  def zaim_token_params
    { zaim_request_token: session[:request_token],
      zaim_request_token_secret: session[:request_secret],
      zaim_access_token: session[:access_token],
      zaim_access_token_secret: session[:access_secret] }
  end

  def unless_coordinated_redirect_to_root(user)
    redirect_to root_path, alert: '許可されていないアクセスです' unless coordinated_with_zaim?(user)
  end

  def list_and_sum_of_payment_by_start_date(money, start_date)
    start_date = start_datetime_by_param(start_date)

    values_by_day = {}
    sum = 0
    money['money'].each do |value|
      break if start_date > value['date']
      unless values_by_day.key?(value['date'])
        values_by_day[value['date']] = []
      end
      tmp_hash = {}
      tmp_hash['category_id'] = value['category_id']
      tmp_hash['amount']      = value['amount']
      sum += value['amount'].to_i
      values_by_day[value['date']] << tmp_hash
    end

    return values_by_day, sum
  end

  def start_datetime_by_param(start_date)
    if start_date == '1'
      Time.zone.yesterday.beginning_of_day
    elsif start_date == '2'
      Time.zone.now.prev_month.beginning_of_day
    else
      Time.zone.now.prev_year.beginning_of_day
    end
  end
end

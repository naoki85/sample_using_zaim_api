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
    unless_cordinated_redirect_to_root(current_user)

    use_zaim_api = UseZaimApi.new(
        current_user.zaim_access_token,
        current_user.zaim_access_token_secret)
    options = { start_date: Time.zone.now.prev_month, mode: 'payment' }
    @money = use_zaim_api.get_list_of_input_money_data(options)
    @category = use_zaim_api.get_category_list
  end

  private

  def zaim_token_params
    { zaim_request_token: session[:request_token],
      zaim_request_token_secret: session[:request_secret],
      zaim_access_token: session[:access_token],
      zaim_access_token_secret: session[:access_secret] }
  end

  def unless_cordinated_redirect_to_root(user)
    redirect_to root_path, alert: '許可されていないアクセスです' unless coordinated_with_zaim?(user)
  end
end

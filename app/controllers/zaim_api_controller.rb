require 'json'
require 'oauth'

class ZaimApiController < ApplicationController
  CONSUMER_KEY     = ENV['ZAIM_CONSUMER_KEY']
  CONSUMER_SECRET  = ENV['ZAIM_CONSUMER_SECRET']
  CALLBACK_URL     = ENV['ZAIM_CALLBACK_URL']

  def login
    set_consumer
    @request_token = @consumer.get_request_token(oauth_callback: CALLBACK_URL)
    session[:request_token] = @request_token.token
    session[:request_secret] = @request_token.secret
    redirect_to @request_token.authorize_url(:oauth_callback => CALLBACK_URL)
  end

  def callback
    if session[:request_token] && params[:oauth_verifier]
      set_consumer
      set_request_token(session[:request_token], session[:request_secret])

      oauth_verifier = params[:oauth_verifier]
      access_token = @request_token.get_access_token(:oauth_verifier => oauth_verifier)
      session[:access_token] = access_token.token
      session[:access_secret] = access_token.secret

      if current_user.update({ zaim_request_token: session[:request_token],
                               zaim_request_token_secret: session[:request_secret],
                               zaim_access_token: session[:access_token],
                               zaim_access_token_secret: session[:access_secret] })
        redirect_to money_path
      else
        logout
      end
    else
      logout
    end
  end

  def money
    set_consumer
    zaim_api = ZaimApi.new(@consumer, session[:access_token], session[:access_secret])
    @money = zaim_api.get_list_of_input_money_data
  end

  def logout
    session[:request_token] = nil
    session[:access_token] = nil
    redirect_to root_path
  end

  private

  def set_consumer
    @consumer = OAuth::Consumer.new(
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
    @request_token = OAuth::RequestToken.new(
        @consumer,
        request_token,
        request_secret
    )
  end
end

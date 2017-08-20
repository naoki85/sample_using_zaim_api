class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, notice: 'ようこそ！'
  end

  def destroy
    Rails.cache.delete("zaim_api/home/money/#{current_user.id}")
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path, notice: 'Login succeeded.'
  end

  def destroy
    reset_session
    Rails.cache.clear
    redirect_to root_path, notice: 'Logout succeeded.'
  end
end
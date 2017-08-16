class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_twitter_api_params)
      redirect_to root_path, notice: 'Success setting API Key.'
    else
      redirect_to edit_user_path, alert: 'Server error was occurred.'
    end
  end

  private

  def user_twitter_api_params
    params.fetch(:user, {}).permit(
        :twitter_consumer_key,
        :twitter_consumer_secret,
        :twitter_access_token,
        :twitter_access_token_secret
    )
  end
end
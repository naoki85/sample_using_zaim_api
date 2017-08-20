class UsersController < ApplicationController

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_twitter_api_params)
      redirect_to root_path, notice: 'API Keyを更新しました。'
    else
      redirect_to edit_user_path, alert: '更新に失敗しました。再度お試しください。'
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
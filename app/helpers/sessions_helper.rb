module SessionsHelper
  # When user is already logged in, return true.
  # Otherwise return false.
  # @return [Boolean]
  def logged_in?
    !!session[:user_id]
  end

  # @return [Object] user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find(user_id)
    end
  end

  # @return [Boolean]
  def already_set_api_key?
    current_user.encrypt_tw_consumer_key and
        current_user.encrypt_tw_consumer_secret and
        current_user.encrypt_tw_access_token and
        current_user.encrypt_tw_access_token_secret
  end
end
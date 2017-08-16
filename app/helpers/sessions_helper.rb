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
end
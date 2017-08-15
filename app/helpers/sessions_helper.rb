module SessionsHelper
  # When user is already logged in, return true.
  # Otherwise return false.
  def logged_in?
    !!session[:user_id]
  end
end
module ZaimApiHelper
  # When user is already logged in Zaim, return true.
  # Otherwise return false.
  # @return [Boolean]
  def logged_in_zaim?
    !!session[:access_token] and !!session[:access_secret]
  end
end
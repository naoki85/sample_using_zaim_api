module ZaimApiHelper
  # When user is already logged in Zaim, return true.
  # Otherwise return false.
  # @return [Boolean]
  def logged_in_zaim?
    !!session[:access_token] and !!session[:access_secret]
  end

  # @param  [Integer] category_id
  # @param  [Integer] amount
  # @return [String]
  def words_category_name_and_amount(category_id, amount)
    category_name = t("views.zaim_api.index.categories.#{@category[category_id.to_i]}")
    money = "#{amount.to_i}円"
    category_name + ' ' + money
  end

  # @param  [String] date
  # @return [Date]
  def json_date_convert_ja_date(date)
    Date.parse(date.to_s).strftime('%Y年%m月%d日')
  end
end
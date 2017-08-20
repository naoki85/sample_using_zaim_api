module ZaimApiHelper
  # When user is already logged in Zaim and values already saved in DB,
  # return true
  # Otherwise return false.
  # @param  [Object]  user
  # @return [Boolean]
  def coordinated_with_zaim?(user)
    user.zaim_request_token.present? &&
      user.zaim_request_token_secret.present? &&
      user.zaim_access_token.present? &&
      user.zaim_access_token_secret.present?
  end

  # @param  [Integer] category_id
  # @param  [Integer] amount
  # @return [String]
  def words_category_name_and_amount(category_id, amount)
    category_name = if @category.key?(category_id.to_i)
                      t("views.zaim_api.index.categories.#{@category[category_id.to_i]}")
                    else
                      '個人設定'
                    end
    money = "#{amount.to_i}円"
    category_name + ' ' + money
  end

  # @param  [String] date
  # @return [Date]
  def json_date_convert_ja_date(date)
    Date.parse(date.to_s).strftime('%Y年%m月%d日')
  end
end
class Tasks::RunnerTweetAchievingGoal

  def self.execute(frequency)
    unless %w(daily monthly yearly).include?(frequency)
      Rails.logger.warn 'Inappropriate argument is specified.'
      return
    end
    users = User.includes([:tweet_messages]).all
    users.each do |user|
      next if user.tweet_messages.size == 0

      # 対象のユーザーが目標値を達成していたか確認
      use_zaim_api = UseZaimApi.new(user.zaim_access_token,
                                    user.zaim_access_token_secret)

      # APIを叩く際のoptionsの構築
      start_date = if frequency == 'daily'
                     Time.zone.now.yesterday
                   elsif frequency == 'monthly'
                     Time.zone.now.prev_month
                   elsif frequency == 'yearly'
                     Time.zone.now.prev_year
                   end
      options = { start_date: start_date, mode: 'payment' }

      # APIを叩き、返却値で支払いの合計値を計算
      money = use_zaim_api.get_list_of_input_money_data(options)
      sum = UseZaimApi.sum_payment_amount(money)

      # 達成していたらツイートする
      use_twitter_api = UseTwitterApi.new(
          user.twitter_consumer_key,
          user.twitter_consumer_secret,
          user.twitter_access_token,
          user.twitter_access_token_secret)

      user.tweet_messages.each do |tweet|
        if tweet.frequency == frequency && tweet.threshold >= sum
          use_twitter_api.tweet_message(tweet.message)
        end
      end
    end
  end
end

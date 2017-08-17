class Tasks::RunnerTweetAchievingGoal
  CONSUMER_KEY     = ENV['ZAIM_CONSUMER_KEY']
  CONSUMER_SECRET  = ENV['ZAIM_CONSUMER_SECRET']

  def self.execute(frequency)
    users = User.includes([:tweet_messages]).all
    users.each do |user|
      next if user.tweet_messages.size == 0
      # 対象のユーザーが目標値を達成していたか確認
      # ZaimApiで計算
      @consumer = OAuth::Consumer.new(
          CONSUMER_KEY,
          CONSUMER_SECRET,
          site: 'https://api.zaim.net',
          request_token_path: '/v2/auth/request',
          authorize_url: 'https://auth.zaim.net/users/auth',
          access_token_path: '/v2/auth/access'
      )

      zaim_api = ZaimApi.new(@consumer, user.zaim_access_token, user.zaim_access_token_secret)

      # TODO: optionsの見直し
      options = { start_date: Time.zone.now.prev_month, mode: 'payment' }
      money = zaim_api.get_list_of_input_money_data(options)
      sum = ZaimApi.sum_payment_amount(money)

      # TweetMessagetの値と比較
      # 達成していたらツイートする
      twitter_api = TwitterApi.new(user.twitter_consumer_key,
                                   user.twitter_consumer_secret,
                                   user.twitter_access_token,
                                   user.twitter_access_token_secret)
      user.tweet_messages.each do |tweet|
        if tweet.threshold >= sum and tweet.frequency == frequency
          twitter_api.tweet_message(tweet.message)
        end
      end
    end
  end
end

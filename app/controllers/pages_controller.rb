class PagesController < ApplicationController
  skip_before_action :authenticate

  def top
    if logged_in?
      @tweet_messages = TweetMessage.where(user_id: current_user.id)
    end
  end
end
class TweetService

  def self.tweet_by_user

  end

  private

  def make_message
    message =  "[To:2025042]\n"
    message << "【イベントボット】\n"
    message << "以下の記事のいいね数が#{@mst_post.like_count}になりました！\n"
    message << @mst_post.title
  end
end

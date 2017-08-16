require 'twitter'
require 'rails_helper'

RSpec.describe TwitterApi, type: :model do

  before do
    @twitter_api = double('Twitter Api')
    allow(@twitter_api).to receive(:tweet_message).and_return("success")
  end

  # TODO: Twitter APIを叩くテストの見直し
  describe '#tweet_message' do
    it '正常にツイートされること' do
      expect{ @twitter_api.tweet_message('hogehoge') }.not_to raise_error
    end
  end
end
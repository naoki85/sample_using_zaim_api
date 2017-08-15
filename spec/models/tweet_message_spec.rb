require 'rails_helper'

RSpec.describe TweetMessage, type: :model do
  describe 'バリデーション' do
    describe '#user_id' do
      it { should validate_presence_of(:user_id) }
    end

    describe '#message' do
      it { should validate_presence_of(:message) }
    end

    describe '#threshold' do
      it { should validate_presence_of(:threshold) }
    end

    describe '#condition' do
      it { should validate_presence_of(:condition) }
    end
  end
end
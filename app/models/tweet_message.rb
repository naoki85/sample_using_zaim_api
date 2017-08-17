class TweetMessage < ApplicationRecord
  belongs_to :user

  validates :user_id,   presence: true
  validates :message,   presence: true
  validates :threshold, presence: true
  validates :frequency, presence: true

  enum frequency: { daily: 1, monthly: 2, yearly: 3 }
end

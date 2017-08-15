class TweetMessage < ApplicationRecord
  belongs_to :user

  validates :user_id,   presence: true
  validates :message,   presence: true
  validates :threshold, presence: true
  validates :condition, presence: true
end

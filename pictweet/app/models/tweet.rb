class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments
  before_create :change_tweet

  def change_tweet
    self.text += "！！"
  end
end

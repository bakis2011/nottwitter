class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9\-\_]+\z/ }, length: { maximum: 15 }

  serialize :device_tokens

  has_many :nottweets, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_many :apns

  mount_uploader :avatar, AvatarUploader

  def favorited?(nottweet)
    favorites.exists?(nottweet_id: nottweet.id)
  end

  def favorite(nottweet)
    favorites.create(nottweet_id: nottweet.id) unless favorited?(nottweet)
  end

  def unfavorite(nottweet)
    favorites.find_by(nottweet_id: nottweet.id).destroy
  end

end

class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9\-\_]+\z/ }, length: { maximum: 15 }

  has_many :borks, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_many :apns, class_name: "Apns"

  mount_uploader :avatar, AvatarUploader

  def favorited?(bork)
    favorites.exists?(bork_id: bork.id)
  end

  def favorite(bork)
    favorites.create(bork_id: bork.id) unless favorited?(bork)
  end

  def unfavorite(bork)
    favorites.find_by(bork_id: bork.id).destroy
  end

end

class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9\-\_]+\z/ }, length: { maximum: 15 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }

  has_many :nottweets, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships
  has_many :followed, through: :relationships

  def following?(user)
    not relationships.find_by(followed_id: user.id).nil?
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

end

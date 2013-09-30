class Bork < ActiveRecord::Base
  acts_as_paranoid
  validates :content, :length => { :maximum => 160 }, :presence => true

  belongs_to :user

  has_many :notifications, dependent: :destroy
  has_many :favorites, dependent: :destroy

  mount_uploader :attachment, AvatarUploader
end

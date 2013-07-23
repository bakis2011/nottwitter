class Nottweet < ActiveRecord::Base
  validates :content, :length => { :maximum => 160 }, :presence => true

  belongs_to :user
  has_many :favorites, dependent: :destroy
  mount_uploader :attachment, AvatarUploader

  if Rails.env.development?
    searchable do
      text :content
    end
  end
end

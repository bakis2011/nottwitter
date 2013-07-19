class Nottweet < ActiveRecord::Base
  belongs_to :user
  has_many :favorites, dependent: :destroy
end

class Nottweet < ActiveRecord::Base
  validates :content, :length => { :maximum => 160 }, :presence => true

  belongs_to :user
  has_many :favorites, dependent: :destroy

end

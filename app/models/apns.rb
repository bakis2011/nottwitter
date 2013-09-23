class Apns < ActiveRecord::Base
  belongs_to :user
  validates :token, uniq: true
end

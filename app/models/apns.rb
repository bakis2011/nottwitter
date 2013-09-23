class Apns < ActiveRecord::Base
  belongs_to :user
  validates :token, uniqueness: true
end

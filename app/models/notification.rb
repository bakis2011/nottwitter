class Notification < ActiveRecord::Base
  belongs_to :user
  before_create :mark_as_unread

  def mark_as_unread
    self.read = false
    true
  end

  def mark_as_read
    self.read = true
    self.save
  end

end

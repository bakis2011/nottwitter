class Notification < ActiveRecord::Base
  belongs_to :user

  def mark_as_read
    self.read = true
    self.save
  end

end

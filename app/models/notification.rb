class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: "User"

  def mark_as_read
    self.read = true
    self.save
  end
end

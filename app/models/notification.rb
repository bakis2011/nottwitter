class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :nottweet
  belongs_to :author, class_name: "User"

  def mark_as_read
    self.read = true
    self.save
  end

  def content
    nottweet ? nottweet.content : nil
  end
end

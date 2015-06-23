class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :bork
  belongs_to :author, class_name: "User"
  before_create :create_api_content

  def mark_as_read
    self.read = true
    self.save
  end

  def content
    bork ? bork.content : nil
  end

  def create_api_content
    if self.action == "favorite"
      self.notification_content = "#{author.username} favorited your bork: \"#{bork.content}\""
    elsif self.action == "mention"
      self.notification_content = "#{author.username} mentioned you in this bork: \"#{bork.content}\""
    end
  end

  # def push_notification
  #   Apns.where(user_id: user_id).each do |apns|
  #     notification = Houston::Notification.new(device: apns.token)
  #     notification.badge = 1
  #     if (action == "favorite")
  #       notification.alert = "#{author.username} favorited your bork \"#{bork.content}\""
  #     else
  #       notification.alert = "#{author.username} mentioned you in his bork \"#{bork.content}\""
  #     end
  #     APN.push(notification)
  #   end
  # end
end

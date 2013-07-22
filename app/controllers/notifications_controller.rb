class NotificationsController < ApplicationController
  after_action :read_all

  def index
    @notifications = current_user.notifications.order('created_at DESC')
  end

private
  def read_all
    @notifications = Notification.where(user_id: current_user.id)
    @notifications.map {|notification| notification.mark_as_read }
  end
end

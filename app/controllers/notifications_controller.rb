class NotificationsController < ApplicationController
  after_action :read_all

  def index
    @notifications = current_user.notifications.order('created_at DESC').page(params[:page]).per(50)
  end

private
  def read_all
    current_user.notifications.update_all(read: true)
  end
end

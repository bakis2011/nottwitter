class AddContentToNotificationForApi < ActiveRecord::Migration
  def change
    add_column :notifications, :notification_content, :string
  end
end

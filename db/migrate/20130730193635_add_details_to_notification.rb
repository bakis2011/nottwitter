class AddDetailsToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :nottweet_id, :integer
    add_column :notifications, :action, :string
  end
end

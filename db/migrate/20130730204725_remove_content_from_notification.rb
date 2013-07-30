class RemoveContentFromNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :content, :string
  end
end

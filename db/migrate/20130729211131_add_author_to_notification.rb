class AddAuthorToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :author_id, :integer
  end
end

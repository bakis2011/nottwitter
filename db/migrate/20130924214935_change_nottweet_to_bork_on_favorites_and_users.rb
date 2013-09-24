class ChangeNottweetToBorkOnFavoritesAndUsers < ActiveRecord::Migration
  def change
    rename_column :favorites, :nottweet_id, :bork_id
    rename_column :notifications, :nottweet_id, :bork_id
  end
end

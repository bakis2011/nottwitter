class AddDeviceTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :device_tokens, :string, default: []
  end
end

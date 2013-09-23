class CreateApns < ActiveRecord::Migration
  def change
    create_table :apns do |t|
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end

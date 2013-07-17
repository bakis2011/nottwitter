class CreateNottweets < ActiveRecord::Migration
  def change
    create_table :nottweets do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end

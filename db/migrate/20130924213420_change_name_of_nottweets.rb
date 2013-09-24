class ChangeNameOfNottweets < ActiveRecord::Migration
  def change
    rename_table :nottweets, :borks
  end
end

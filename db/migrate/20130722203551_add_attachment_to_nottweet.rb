class AddAttachmentToNottweet < ActiveRecord::Migration
  def change
    add_column :nottweets, :attachment, :string
  end
end

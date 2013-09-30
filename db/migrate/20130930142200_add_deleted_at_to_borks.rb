class AddDeletedAtToBorks < ActiveRecord::Migration
  def change
    add_column :borks, :deleted_at, :datetime
  end
end

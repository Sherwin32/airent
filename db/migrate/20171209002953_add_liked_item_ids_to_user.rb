class AddLikedItemIdsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :liked_item_ids, :integer, array:true, default: []
  end
end

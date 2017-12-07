class AddPostImageToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :post_image_id, :string
  end
end

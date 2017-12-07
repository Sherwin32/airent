class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.string :price
      t.text :history_log
      t.integer :tenant_id
      t.integer :owner_id
      t.integer :request_id_list, array:true, default: []

      t.timestamps
      t.belongs_to :group
    end
  end
end

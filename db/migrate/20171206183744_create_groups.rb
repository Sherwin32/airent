class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :manager_ids, array:true, default: []
      t.string :passcode

      t.timestamps
    end
  end
end

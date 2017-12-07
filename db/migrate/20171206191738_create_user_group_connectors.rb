class CreateUserGroupConnectors < ActiveRecord::Migration[5.1]
  def change
    create_table :user_group_connectors do |t|
      t.timestamps

      t.belongs_to :group
      t.belongs_to :user
    end
  end
end

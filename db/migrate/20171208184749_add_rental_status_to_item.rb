class AddRentalStatusToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :rental_status, :string
  end
end

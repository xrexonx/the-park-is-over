class RemoveColumnsFromParking < ActiveRecord::Migration[5.2]
  def change
    remove_column :parkings, :slot_number, :string
    remove_column :parkings, :vehicle_type, :string
    remove_reference :parkings, :entry_point, foreign_key: true
  end
end

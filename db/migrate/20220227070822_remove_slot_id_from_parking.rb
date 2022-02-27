class RemoveSlotIdFromParking < ActiveRecord::Migration[5.2]
  def change
    remove_column :parkings, :slot_id, :string
  end
end

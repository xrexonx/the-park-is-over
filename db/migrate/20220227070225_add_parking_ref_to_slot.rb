class AddParkingRefToSlot < ActiveRecord::Migration[5.2]
  def change
    add_reference :slots, :parking, foreign_key: true
  end
end

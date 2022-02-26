class CreateParkings < ActiveRecord::Migration[5.2]
  def change
    create_table :parkings do |t|
      t.datetime :entry_datetime
      t.datetime :exit_datetime
      t.string :vehicle_type
      t.string :slot_number
      t.string :plate_number
      t.references :entry_point, foreign_key: true

      t.timestamps
    end
  end
end

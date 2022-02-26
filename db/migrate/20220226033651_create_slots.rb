class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.string :name
      t.string :status
      t.integer :rate
      t.references :entry_point, foreign_key: true

      t.timestamps
    end
  end
end

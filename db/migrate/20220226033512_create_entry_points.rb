class CreateEntryPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_points do |t|
      t.string :name

      t.timestamps
    end
  end
end

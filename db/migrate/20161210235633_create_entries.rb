class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.integer :sensor_id
      t.float :temperature
      t.float :humidity

      t.timestamps
    end
  end
end

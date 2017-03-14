class CreateDeviceEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :device_entries do |t|
      t.string :state
      t.integer :device_id

      t.timestamps
    end
  end
end

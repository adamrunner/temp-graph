class AddIndexToEntries < ActiveRecord::Migration[5.0]
  def change
    add_index(:entries, [:sensor_id, :temperature, :humidity, :created_at], unique: true, name: :index_entries_on_attributes)
  end
end

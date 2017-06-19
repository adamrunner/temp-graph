class AddEntriesCountToSensor < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :entries_count, :integer, default: 0

    reversible do |dir|
      dir.up { data }
    end
  end
  def data
      execute <<-SQL.squish
          UPDATE sensors
             SET entries_count = (SELECT count(1)
                                    FROM entries
                                    WHERE entries.sensor_id = sensors.id)
      SQL
    end
end

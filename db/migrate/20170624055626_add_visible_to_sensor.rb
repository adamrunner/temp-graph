class AddVisibleToSensor < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :visible, :boolean, default: true
  end
end

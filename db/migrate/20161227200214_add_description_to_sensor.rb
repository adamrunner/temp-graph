class AddDescriptionToSensor < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :description, :string
  end
end

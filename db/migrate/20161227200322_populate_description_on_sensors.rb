class PopulateDescriptionOnSensors < ActiveRecord::Migration[5.0]
  def up
    Sensor.find_by_name("ESP_0BA4E4").update_column(:description, 'Kitchen, on top of plant light')
    Sensor.find_by_name("ESP_E2106F").update_column(:description, 'Living Room, on east wall')
  end

  def down
  end
end

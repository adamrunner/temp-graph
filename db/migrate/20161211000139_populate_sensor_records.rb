class PopulateSensorRecords < ActiveRecord::Migration[5.0]
  def up
    sensor_attributes = [
      {name: "Outside"},
      {name: "Inside 1"},
      {name: "Inside 2"}
    ]
    sensor_attributes.each do |sensor_attrs|
      Sensor.create(sensor_attrs)
    end
  end

  def down
    Sensor.destroy_all
  end
end

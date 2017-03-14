class PopulateDevices < ActiveRecord::Migration[5.0]
  def up
    %w{PSU LED Pump}.each do |name|
      Device.create(name: name)
    end
  end

  def down
  end
end

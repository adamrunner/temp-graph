class AddFriendlyNameToSensor < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :friendly_name, :string
  end
end

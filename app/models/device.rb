class Device < ApplicationRecord
  has_many :entries, class_name: 'DeviceEntry'

  def latest_entry
    entries.last
  end

  def on?
    latest_entry.state.downcase == "on" 
  end

  def off?
    latest_entry.state.downcase == "off"
  end

end

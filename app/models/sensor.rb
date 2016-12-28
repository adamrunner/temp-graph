class Sensor < ApplicationRecord
  has_many :entries

  scope :inside, -> { where.not(name: ['testing', 'outside'])   }

  def last_temp
    entries.last.temperature
  end

  def last_entry_time
    entries.last.created_at
  end
end

class Sensor < ApplicationRecord
  has_many :entries

  scope :inside, -> { where.not(name: ['testing'])   }

  def last_temp
    entries.last.temperature
  end

  def last_entry_time
    entries.last.created_at
  end

  def lowest_logged_temp
    entries.order(:temperature).first
  end

  def highest_logged_temp
    entries.order(temperature: :desc).first
  end

  def latest_entries
    entries.where("created_at > ?", 1.day.ago)
  end
end

class Sensor < ApplicationRecord
  has_many :entries

  scope :visible, -> { where(visible:  true)  }
  scope :inside, -> { where.not(name: ['testing'])  }
  scope :with_entries, -> { where('entries_count > 0') }
  scope :not_reporting, -> { inside.select {|s| s.last_entry_time <  5.minutes.ago } }

  def toggle_visibility!
    visible = visible? ? false : true
    update_column(:visible, visible)
  end

  def last_temp
    entries.last.try(:temperature)
  end

  def last_entry_time
    entries.last.try(:created_at)
  end

  def lowest_logged_temp
    entries.order(:temperature).first.try(:temperature)
  end

  def highest_logged_temp
    entries.order(temperature: :desc).first.try(:temperature)
  end

  def latest_entries
    entries.where("created_at > ?", 1.day.ago).order(:created_at)
  end

  def average_temp(time = 6.hours.ago)
    if entries.count > 0
      entries.where("created_at > ?", time).average(:temperature).round(2)
    else
      0.0
    end
  end
end

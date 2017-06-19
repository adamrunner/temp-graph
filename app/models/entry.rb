class Entry < ApplicationRecord
  belongs_to :sensor, counter_cache: true
end

@sensors.each do |sensor|
  json.set! sensor.name do
    json.array! sensor.entries.where("created_at > ?", 1.day.ago).map{|e| [(e.created_at.to_i * 1000), e.temperature]}
  end
end

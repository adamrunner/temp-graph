@data.each do |data|
  json.set! data[:sensor].friendly_name do
    json.array! data[:entries].map{|e| [(e.created_at.to_i * 1000), e.temperature]}
  end
end

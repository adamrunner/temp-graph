namespace :temp_graph do
  desc "Runs the MQTT Watcher that persists messages to the DB"
  task :mqtt_watcher => :environment do

    def sensor_names
      @sensor_names ||= Sensor.pluck(:name)
    end

    def device_names
      @device_names ||= Device.pluck(:name)
    end

    def perform
      MQTT::Client.connect('temp.adamrunner.com') do |c|
        c.get('outTopic') do |topic,message|
          msg = message.split(',')
          if sensor_names.include?(msg[0])
            sensor      = Sensor.find_or_create_by!(name:msg[0])
            sensor.entries.create(temperature: msg[1])
            puts "#{DateTime.now.iso8601} - #{msg[0]} - #{msg[1]}"
          end
          if device_names.include?(msg[0])
            device = Device.find_by(name: msg[0])
            device.entries.create(state: msg[1])
            puts "#{DateTime.now.iso8601} - #{msg[0]} - #{msg[1]}"
          end
        end
      end
    end
    perform
  end
end

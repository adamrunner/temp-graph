class ForecastIoWorker
  include Sidekiq::Worker

  def perform(*args)
    outside_temp = ForecastIO.forecast(*TempGraph::Application.config.location)["currently"]["temperature"]
    sensor       = Sensor.find_by(name: "Outside")
    sensor.entries.create(temperature: outside_temp)
    MQTT::Client.connect('temp.adamrunner.com') do |c|
      c.publish('outTopic', "#{sensor.name},#{outside_temp}")
    end
  end
end

require 'rails_helper'

RSpec.describe TempsController, type: :controller do
  let(:sensor) { Sensor.create(name:'Testing') }
  let(:temperature) { 75.25 }
  let(:humidity) { 25.25 }
  describe "GET receive" do
    it "creates a new entry for the sensor" do
      get :receive, params: {sensor_name: sensor.name, temperature: temperature, humidity: humidity}
      expect(response).to have_http_status(:created)
      expect(sensor.entries.reload.last.temperature).to eq(temperature)
      expect(sensor.entries.reload.last.humidity).to eq(humidity)
    end
  end
end

class TempsController < ApplicationController
  before_action :load_sensors, only: [:chart_data, :index]
  # before_filter :load_devices, only: []

  def receive
    sensor_name = params[:sensor_name]
    sensor      = Sensor.find_or_create_by!(name:sensor_name)
    sensor.entries.create(temperature: params[:temperature], humidity: params[:humidity])
    respond_to do |format|
      format.any { head :created, content_type: "text/html" }
    end
  end

  def index
    @data    = @sensors.map {|s| {sensor: s, entries: s.latest_entries} }
    respond_to do |format|
      format.html
    end
  end

  def request_update
    ForecastIoWorker.perform_async
    respond_to do |format|
      format.json { render json: {success: true}, status: :ok }
    end
  end

  def chart_data
    @data = @sensors.map {|s| {sensor: s, entries: s.latest_entries}  }
    respond_to do |format|
      format.json
    end
  end

  private

  def load_sensors
    @all_sensors = Sensor.inside
    @sensors     = Sensor.inside.with_entries.visible
  end

  def load_devices
    @devices = Device.all
  end
end

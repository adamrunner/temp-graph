class TempsController < ApplicationController

  def receive
    sensor_name = params[:sensor_name]
    sensor      = Sensor.find_or_create_by!(name:sensor_name)
    sensor.entries.create(temperature: params[:temperature], humidity: params[:humidity])
    respond_to do |format|
      format.any { head :created, content_type: "text/html" }
    end
  end

  def index
    @sensors = Sensor.inside.with_entries
    @data    = @sensors.map {|s| {sensor: s, entries: s.latest_entries} }
    # @devices = Device.all
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
    @data = Sensor.inside.map {|s| {sensor: s, entries: s.latest_entries}  }
    respond_to do |format|
      format.json
    end
  end
end

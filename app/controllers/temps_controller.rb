class TempsController < ApplicationController

  def receive
    #TODO: receive params from ESP controllers and create new database entries
    sensor_name = params[:sensor_name]
    sensor      = Sensor.find_or_create_by!(name:sensor_name)
    sensor.entries.create(temperature: params[:temperature], humidity: params[:humidity])
    respond_to do |format|
      format.any { head :created, content_type: "text/html" }
    end
  end

  def index
    @sensors = Sensor.inside
    respond_to do |format|
      format.html
    end
  end
end

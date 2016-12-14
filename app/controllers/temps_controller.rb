class TempsController < ApplicationController

  def receive
    #TODO: receive params from ESP controllers and create new database entries
    sensor_name = params[:sensor_name]
    sensor      = Sensor.find_by_name!(sensor_name)
    sensor.entries.create(temperature: params[:temperature], humidity: params[:humidity])
    respond_to do |format|
      format.any { head :created, content_type: "text/html" }
    end
  end

  def nothing
    respond_to do |format|
      format.html { render html: "<strong>OK</strong>".html_safe}
      format.json { render json: @resource }
    end
  end
end

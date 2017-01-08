class EntriesController < ApplicationController
  before_action :find_sensor, :find_entries
  def index
    respond_to do |format|
      format.html
      format.json { render json: @entries }
    end
  end

  private
  def find_sensor
    @sensor = Sensor.find(params[:sensor_id])
  end

  def find_entries
    # Default Search Params
    @entries = @sensor.entries.where("created_at > ?", 1.day.ago)
  end
end

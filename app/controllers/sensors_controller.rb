class SensorsController < ApplicationController
  before_action :find_sensor, except: :index

  def index
    @sensors = Sensor.all
    respond_to do |format|
      format.html
      format.json { render json: @sensors }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @sensor }
    end
  end

  private
  def find_sensor
    @sensor = Sensor.find(params[:id])
  end

end

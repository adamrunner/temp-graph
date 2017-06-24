class SensorsController < ApplicationController
  before_action :find_sensor, except: :index

  def index
    @sensors = Sensor.all
    respond_to do |format|
      format.html
      format.json { render json: @sensors }
    end
  end

  def toggle
    @sensor.toggle_visibility!

    respond_to do |format|
      format.html { redirect_to :back, notice: "Updated sensor display!"}
      format.json { render json: @sensor }
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

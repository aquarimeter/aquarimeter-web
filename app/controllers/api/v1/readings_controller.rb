class Api::V1::ReadingsController < Api::V1::BaseController
  before_filter :authenticate_user, :except => :index

  def index
    @readings = SensorReading.all
    render @readings, status: :ok
  end

  def create
    @reading = SensorReading.new(reading_params)
    if @reading.save
      render :json => @reading, status: :created, location => [:api, @reading]
    else
      render json => @reading.errors, status => :unprocessable_entity
    end
  end

  private
  def reading_params
    params.require(:reading).permit(:ph, :temperature)
  end
end

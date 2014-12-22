class Api::V1::ReadingsController < Api::V1::BaseController
  before_filter :authenticate_user, :except => [:show]
  before_filter :set_aquarium

  def show
    @readings = SensorReading.where(:aquarium => @aquarium)
    render json: @readings
  end

  def create
    @reading = SensorReading.new(reading_params)
    @reading.aquarium = @aquarium
    if @reading.save
      render :json => @reading, status: :created, location => [:api, @reading]
    else
      render json => @reading.errors, status => :unprocessable_entity
    end
  end
  def update
    render status: :not_implemented, json: {message: "Cannot update readings"}
  end
  private
  def set_aquarium
    @aquarium = Aquarium.find_by(:name => params[:aquarium_name])
  end

  def reading_params
    params.require(:reading).permit(:ph, :temperature)
  end
end

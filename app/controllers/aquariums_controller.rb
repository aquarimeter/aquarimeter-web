class AquariumsController < ApplicationController
  before_filter :set_aquarium
  before_filter :authenticate_user!, :except => [:show]
  respond_to :html

  def show
    unless @aquarium
      flash[:error] = "Aquarium #{params[:name]} does not exist."
      redirect_to root_url
    else
      respond_with do |format|
        format.html
        @aquarium
        @readings = @aquarium.sensor_readings
        format.json { render json: SensorReadingDatatable.new(view_context) }
      end
    end
  end


  def index
    @aquariums = Aquarium.where(:user_id => current_user.id)
    respond_with html: @aquariums

  end

  # update avatar
  def update

  end


  protected

  def set_aquarium
    @aquarium = Aquarium.find_by(name: params[:name])
  end

  def aquarium_params
    params.require(:aquarium).permit(:name, :ideal_temperature, :ideal_temp_low, :ideal_temp_high, :images, :avatars)
  end
end
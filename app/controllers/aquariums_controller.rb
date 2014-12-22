class AquariumsController < ApplicationController
  before_filter :set_aquarium
  respond_to :html
  def show
    respond_with do |format|
      format.html { @aquarium }
    end

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

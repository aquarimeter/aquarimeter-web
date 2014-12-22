class AquariumsController < ApplicationController
  before_filter :set_aquarium
  before_filter :authenticate_user!, :only => [:show, :index]

  respond_to :html
  def show
    respond_with do |format|
      format.html { @aquarium }
    end
  end


  def index
    @aquariums = Aquarium.where(:user_id => current_user.id)
    respond_with do |format|
      format.html { @aquariums }
    end
  end

  def update
    @aquarium = Aquarium.find_by params[:name]

  end

    protected

    def set_aquarium
      @aquarium = Aquarium.find_by(name: params[:name])
    end

    def aquarium_params
      params.require(:aquarium).permit(:name, :ideal_temperature, :ideal_temp_low, :ideal_temp_high, :images, :avatars)
    end
  end

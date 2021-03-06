class Api::V1::AquariumsController < Api::V1::BaseController
  before_filter :authenticate_user, :except => [:index,:show]


  def create
    @aquarium = Aquarium.new(aquarium_params)
    @aquarium.user = @current_user
    if @aquarium.save
      respond_with @aquarium, :status => :created
    else
      render json: @aquarium.errors, status: :unprocessable_entity
    end
  end

  def update
    @aquarium = Aquarium.find_by(:name => params[:aquarium][:name])
    if @aquarium.update_attributes(aquarium_params)
      render json: @aquarium, status: :created
    else
      render json: @aquarium.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @aquarium = Aquarium.find(params[:id])
    if @aquarium.user != current_user
      render json: "Not authorized", status: :unauthorized
    else
      render json: "Deleted aquarium #{@aquarium.id}.", status: :ok
    end
  end

  def show
    @aquarium = Aquarium.find_by(:name => params[:name])
    if @aquarium
      render json: @aquarium, status: :ok
    else
      render json: {error: "An aquarium with the name #{params[:name]} does not exist."}, status: :not_found
    end
  end

  def index
    @aquariums = Aquarium.all_aquariums_by_user
    render json: @aquariums, status: :ok
  end

  protected
  def aquarium_params
    params.require(:aquarium).permit(:name, :ideal_temperature, :ideal_temp_low, :ideal_temp_high)
  end
end

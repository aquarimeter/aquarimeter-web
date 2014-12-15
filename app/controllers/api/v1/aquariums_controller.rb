class Api::V1::AquariumsController < Api::V1::BaseController
  before_filter :authenticate_user, :except => :index


  def create
    @aquarium = Aquarium.new(aquarium_params)
    @aquarium.user = @current_user
    puts params.pretty_print_inspect
    if @aquarium.save
      render json: @aquarium, status: :created
    else
      render json: @aquarium.errors, status: :unprocessable_entity
    end
  end

  def update
    if @aquarium.update_attributes(aquarium_params)
      render json: @aquarium, status: 201, location: [:api, @aquarium]
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

  end

  def index
    @aquariums = Aquarium.all
    render json: @aquariums, success: :ok
  end

  protected
  def aquarium_params
    params.require(:aquarium).permit(:name, :ideal_temp_low, :ideal_temp_high)
  end
end

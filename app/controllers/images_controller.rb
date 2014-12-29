class ImagesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_filter :set_aquarium
  before_action :set_image, only: [:edit, :update, :destroy]
  before_action :set_images, only: [:show]

    # GET /images
  # GET /images.json
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.slim
      format.json { render json: @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @images = Image.where(:aquarium => @aquarium).page(params[:page]).per(4)
    respond_to do |format|
      format.html # show.html.slim
    end
  end

  # GET /images/new
  def new
    @image = Image.new
    @image.aquarium = @aquarium
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to aquarium_images_url, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  def set_images
    @image = Image.find_by :aquarium => @aquarium
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:image,:aquarium_id)
  end

  private
  def set_aquarium
    @aquarium = Aquarium.find_by :name => params[:aquarium_name]
    if not @aquarium
      flash[:error] = "This will not work without an aquarium!"
      redirect_to root_url
    end
  end
end

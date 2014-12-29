class Api::V1::ImagesController < Api::V1::BaseController
  before_filter :authenticate_user, :except => [:index, :show]
  before_filter :set_aquarium


  def new
    @image = Image.new(:aquarium_id => Aq)
  end


  # taken from http://ograycoding.wordpress.com/2012/07/03/api-upload-with-carrierwave/
  # assumes the following json
  def create
    #check if file is within picture_path
    if params[:image][:image_path]["file"]
      picture_path_params = params[:image][:image_path]
      #create a new tempfile named fileupload
      tempfile = Tempfile.new("fileupload")
      tempfile.binmode
      #get the file and decode it with base64 then write it to the tempfile
      tempfile.write(Base64.decode64(picture_path_params["file"]))

      #create a new uploaded file
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => picture_path_params["filename"], :original_filename => picture_path_params["original_filename"])

      #replace picture_path with the new uploaded file
      params[:image][:image_path] = uploaded_file

    end

    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end

    def edit
      @image = Image.find(params[:id])
    end

    def update
      @image = Image.find(params[:id])

      if @image.update_attributes(params[:image])
        respond_with do |format|
          format.html do
            flash[:notice] = "Successfully updated image."
            redirect_to @image.aquarium
          end
          format.json { render json: @image.aquariam, :status => :created }
        end
      else
        respond_with do |format|
          format.html { render :action, 'edit' }
          format.json { render json: @image.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = "Successfully destroyed image."
    redirect_to @image.gallery
  end

  def show
    respond_to do |format|
      format.html # show.html.slim
      format.json { render json: @image }
    end
  end
  private
  def set_aquarium
    @aquarium = Aquarium.find_by :name => params[:aquarium_name]
  end


end

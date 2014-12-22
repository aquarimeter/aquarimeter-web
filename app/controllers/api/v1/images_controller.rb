class Api::V1::ImagesController < Api::V1::BaseController
  before_filter :authenticate_user, :except => [:show, :index]
  before_filter :set_image, :only => [:create, :update, :show, :destroy]

  def show

  end

  def index

  end

  def create
    #check if file is within picture_path
    if params[:image][:image_path]["file"]
      picture_path_params = params[:image][:picture_path]
      #create a new tempfile named fileupload
      tempfile = Tempfile.new("fileupload")
      tempfile.binmode
      #get the file and decode it with base64 then write it to the tempfile
      tempfile.write(Base64.decode64(image_path_params["file"]))

      #create a new uploaded file
      uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => image_path_params["filename"], :original_filename => image_path_params["original_filename"])

      #replace picture_path with the new uploaded file
      params[:image][:image_path] =  uploaded_file

    end

    @image = Image.new(params[:image])
    tempfile.delete

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy

  end


  def set_image
    @image = Image.find(params[:id])
  end

  protected
  def aquarium_params
    params.require(:image)
  end
end

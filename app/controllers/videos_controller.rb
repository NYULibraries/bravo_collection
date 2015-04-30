class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  def index
    @videos = Video.all
  end

  # GET /videos/1
  def show
    @video = Video.friendly.find(params[:id])
    same_interviewee = Video.where(name: @video.name).where.not(id: @video.id).limit(12)
    if same_interviewee.count < 12
      grid_limit = 12 - same_interviewee.count
      other_video = Video.where(film_id: @video.film_id).where.not(id: @video.id, name: @video.name).limit(grid_limit).order("RAND()")
      @related_video = (same_interviewee + other_video).uniq
    else
      @related_video = same_interviewee
    end
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to @video, notice: 'Video was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /videos/1
  def update
    if @video.update(video_params)
      redirect_to @video, notice: 'Video was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /videos/1
  def destroy
    @video.destroy
    redirect_to videos_url, notice: 'Video was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def video_params
      params.require(:video).permit(:title, :name, :description, :time, :thumbnail)
    end
end

class FilmsController < ApplicationController
  def index
    @films = Film.all
    @film_grid = Film.all
  end

  def show
    @film = Film.friendly.find(params[:id])
    @related_video = Film.friendly.find(params[:id]).videos.order(name: :asc, refid: :asc)
  end

  private
    def film_params
      params.require(:film).permit(:title, :year, :time, :description, :thumbnail)
    end
end

class CollectionsController < ApplicationController
  def index
    redirect_to "/collections/1"
  end

  def show
    @collection = Collection.friendly.find(params[:id])
    @videos = Video.where(collection_id: @collection.id).order(name: :asc, refid: :asc)
  end

  private

    def collection_params
      params.require(:collection).permit(:title, :description, :slug, :image)
    end
end

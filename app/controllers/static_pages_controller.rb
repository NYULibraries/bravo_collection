class StaticPagesController < ApplicationController
  def home
    @video_grid = Video.order('id DESC').limit(6)
  end

  def contact
  end

  def estela_bravo
  end

  def bravo_collection
  end

  def tamiment_library
  end

  def video_rights
  end
end

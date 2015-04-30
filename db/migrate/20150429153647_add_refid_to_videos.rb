class AddRefidToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :refid, :string
  end
end

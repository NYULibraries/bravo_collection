class AddRefidToVideos < ActiveRecord::Migration[4.2]
  def change
    add_column :videos, :refid, :string
  end
end

class AddnameToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :name, :string
  end
end

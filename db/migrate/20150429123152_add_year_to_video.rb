class AddYearToVideo < ActiveRecord::Migration[4.2]
  def change
    add_column :videos, :year, :string
  end
end

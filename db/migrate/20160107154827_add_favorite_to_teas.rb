class AddFavoriteToTeas < ActiveRecord::Migration
  def change
    add_column :teas, :favorite, :boolean, :default => false
  end
end

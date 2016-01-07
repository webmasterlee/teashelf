class RemoveFavoriteFromTeas < ActiveRecord::Migration
  def change
    remove_column :teas, :favorite
  end
end

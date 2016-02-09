class AddArchiveToTeas < ActiveRecord::Migration
  def change
    add_column :teas, :archive, :boolean, :default => false
  end
end
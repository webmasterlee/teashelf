class AddRecentUpdateToTeas < ActiveRecord::Migration
  def change
    add_column :teas, :recent_update, :date
  end
end

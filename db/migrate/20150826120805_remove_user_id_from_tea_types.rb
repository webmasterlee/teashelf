class RemoveUserIdFromTeaTypes < ActiveRecord::Migration
  def change
    remove_column :tea_types, :user_id, :integer
  end
end

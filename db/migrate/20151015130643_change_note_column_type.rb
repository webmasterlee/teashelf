class ChangeNoteColumnType < ActiveRecord::Migration
  def change
  	change_column :notes, :body, :text
  end
end

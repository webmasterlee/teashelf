class ChangeExclusionColumnName < ActiveRecord::Migration
  def change
  	rename_column :exclusions, :attribute, :attr
  end
end

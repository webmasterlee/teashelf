class CreateExclusions < ActiveRecord::Migration
  def change
    create_table :exclusions do |t|
      t.string :attribute
      t.string :value
      t.references :user, index: true

      t.timestamps
    end
  end
end

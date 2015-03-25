class CreateTeaTypes < ActiveRecord::Migration
  def change
    create_table :tea_types do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end

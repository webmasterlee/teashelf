class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.text :name
      t.text :value
      t.references :user, index: true

      t.timestamps
    end
  end
end

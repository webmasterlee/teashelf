class CreateTeas < ActiveRecord::Migration
  def change
    create_table :teas do |t|
      t.string :name
      t.string :stock
      t.text :notes
      t.string :url
      t.references :user, index: true
      t.references :tea_type, index: true

      t.timestamps
    end
  end
end

class CreateAtts < ActiveRecord::Migration
  def change
    create_table :atts do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end

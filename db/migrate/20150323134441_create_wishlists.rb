class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.string :name
      t.text :notes
      t.string :url
      t.references :user, index: true

      t.timestamps
    end
  end
end

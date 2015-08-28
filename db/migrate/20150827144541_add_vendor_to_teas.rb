class AddVendorToTeas < ActiveRecord::Migration
  def change
    add_column :teas, :vendor, :string
  end
end

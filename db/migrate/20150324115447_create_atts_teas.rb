class CreateAttsTeas < ActiveRecord::Migration
  def change
    create_table :atts_teas do |t|
    	t.belongs_to :att, index: true
      	t.belongs_to :tea, index: true
    end
  end
end

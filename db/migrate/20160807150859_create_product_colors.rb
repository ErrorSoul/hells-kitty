class CreateProductColors < ActiveRecord::Migration
  def change
    create_table :product_colors do |t|
      t.integer :color_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end

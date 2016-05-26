class CreateProductSizes < ActiveRecord::Migration
  def change
    create_table :product_sizes do |t|
      t.integer :value
      t.belongs_to :product, index: true, foreign_key: true
      t.belongs_to :size, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

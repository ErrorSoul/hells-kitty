class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.integer :category_id
      t.string  :marking

      t.timestamps null: false
    end
  end
end

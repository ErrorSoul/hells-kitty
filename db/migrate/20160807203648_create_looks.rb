class CreateLooks < ActiveRecord::Migration
  def change
    create_table :looks do |t|
      t.integer :product_id_0
      t.integer :product_id_1
      t.integer :product_id_2
      t.integer :product_id_3

      t.timestamps null: false
    end
  end
end

class CreateProductAttachments < ActiveRecord::Migration
  def change
    create_table :product_attachments do |t|
      t.string :asset
      t.integer :product_id  
      t.timestamps null: false
    end
  end
end

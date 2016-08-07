class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :code

      t.timestamps null: false
    end
  end
end

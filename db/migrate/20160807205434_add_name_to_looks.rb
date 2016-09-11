class AddNameToLooks < ActiveRecord::Migration
  def change
    add_column :looks, :name, :string
  end
end

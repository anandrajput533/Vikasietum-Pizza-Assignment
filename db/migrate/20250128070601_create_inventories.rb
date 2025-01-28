class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.string :ingredient_name
      t.integer :stock

      t.timestamps
    end
  end
end

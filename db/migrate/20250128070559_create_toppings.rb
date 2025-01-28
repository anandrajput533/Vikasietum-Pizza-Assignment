class CreateToppings < ActiveRecord::Migration[7.1]
  def change
    create_table :toppings do |t|
      t.string :name
      t.integer :price
      t.boolean :is_vegetarian

      t.timestamps
    end
  end
end

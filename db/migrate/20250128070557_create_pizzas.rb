class CreatePizzas < ActiveRecord::Migration[7.1]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.string :size
      t.integer :price
      t.boolean :is_vegetarian

      t.timestamps
    end
  end
end

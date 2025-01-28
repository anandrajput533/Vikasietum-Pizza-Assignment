class CreateOrderPizzas < ActiveRecord::Migration[7.1]
  def change
    create_table :order_pizzas do |t|
      t.references :order, null: false, foreign_key: true
      t.references :pizza, null: false, foreign_key: true

      t.timestamps
    end
  end
end

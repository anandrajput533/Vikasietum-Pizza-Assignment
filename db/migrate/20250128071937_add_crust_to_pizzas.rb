class AddCrustToPizzas < ActiveRecord::Migration[7.1]
  def change
    add_reference :pizzas, :crust, null: false, foreign_key: true
  end
end

# db/seeds.rb

# Creating Crusts
crust1 = Crust.create!(name: 'New hand tossed')
crust2 = Crust.create!(name: 'Wheat thin crust')
crust3 = Crust.create!(name: 'Cheese Burst')
crust4 = Crust.create!(name: 'Fresh pan pizza')

# Creating Toppings (ensure is_vegetarian is specified)
topping1 = Topping.create!(name: 'Black Olive', price: 20, is_vegetarian: true)
topping2 = Topping.create!(name: 'Capsicum', price: 25, is_vegetarian: true)
topping3 = Topping.create!(name: 'Paneer', price: 35, is_vegetarian: true)
topping4 = Topping.create!(name: 'Mushroom', price: 30, is_vegetarian: true)
topping5 = Topping.create!(name: 'Fresh Tomato', price: 10, is_vegetarian: true)
topping6 = Topping.create!(name: 'Chicken Tikka', price: 35, is_vegetarian: false)
topping7 = Topping.create!(name: 'Barbeque Chicken', price: 45, is_vegetarian: false)
topping8 = Topping.create!(name: 'Grilled Chicken', price: 40, is_vegetarian: false)
topping9 = Topping.create!(name: 'Extra Cheese', price: 35, is_vegetarian: true)

# Creating Pizzas for Vegetarians
pizza1 = Pizza.create!(name: 'Deluxe Veggie', size: 'Regular', price: 150, is_vegetarian: true, crust: crust1)
pizza2 = Pizza.create!(name: 'Cheese and Corn', size: 'Medium', price: 375, is_vegetarian: true, crust: crust2)
pizza3 = Pizza.create!(name: 'Paneer Tikka', size: 'Large', price: 340, is_vegetarian: true, crust: crust3)

# Creating Pizzas for Non-Vegetarians
pizza4 = Pizza.create!(name: 'Non-Veg Supreme', size: 'Regular', price: 190, is_vegetarian: false, crust: crust1)
pizza5 = Pizza.create!(name: 'Chicken Tikka', size: 'Medium', price: 370, is_vegetarian: false, crust: crust2)
pizza6 = Pizza.create!(name: 'Pepper Barbecue Chicken', size: 'Large', price: 525, is_vegetarian: false, crust: crust4)

# Associating Toppings to Vegetarian Pizzas
PizzaTopping.create!(pizza: pizza1, topping: topping1)
PizzaTopping.create!(pizza: pizza1, topping: topping2)
PizzaTopping.create!(pizza: pizza2, topping: topping3)
PizzaTopping.create!(pizza: pizza2, topping: topping4)
PizzaTopping.create!(pizza: pizza3, topping: topping5)

# Associating Toppings to Non-Vegetarian Pizzas
PizzaTopping.create!(pizza: pizza4, topping: topping6)
PizzaTopping.create!(pizza: pizza4, topping: topping7)
PizzaTopping.create!(pizza: pizza5, topping: topping6)
PizzaTopping.create!(pizza: pizza5, topping: topping7)
PizzaTopping.create!(pizza: pizza6, topping: topping7)
PizzaTopping.create!(pizza: pizza6, topping: topping8)

# Creating Sides
side1 = Side.create!(name: 'Cold Drink', price: 55)
side2 = Side.create!(name: 'Mousse Cake', price: 90)

# Creating Inventory
Inventory.create!(ingredient_name: 'Cheese', stock: 100)
Inventory.create!(ingredient_name: 'Capsicum', stock: 50)
Inventory.create!(ingredient_name: 'Paneer', stock: 50)
Inventory.create!(ingredient_name: 'Chicken Tikka', stock: 60)
Inventory.create!(ingredient_name: 'Barbeque Chicken', stock: 40)
Inventory.create!(ingredient_name: 'Mushroom', stock: 30)
Inventory.create!(ingredient_name: 'Olive', stock: 20)

# Creating Orders
order1 = Order.create!(total_price: 30, status: 'confirmed')
order2 = Order.create!(total_price: 60, status: 'confirmed')

# Associating Pizzas with Orders
OrderPizza.create!(order: order1, pizza: pizza1)
OrderPizza.create!(order: order2, pizza: pizza4)

# Associating Sides with Orders
OrderSide.create!(order: order1, side: side1)
OrderSide.create!(order: order2, side: side2)

puts "Seed data created successfully!"

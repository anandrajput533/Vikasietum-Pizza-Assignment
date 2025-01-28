class Pizza < ApplicationRecord

  validates :name, presence: true
  validates :price, presence: true
  validates :size, presence: true
 

  belongs_to :crust
  has_many :pizza_toppings
  has_many :toppings, through: :pizza_toppings
  has_many :order_pizzas
  has_many :orders, through: :order_pizzas

  
end

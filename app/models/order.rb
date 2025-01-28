class Order < ApplicationRecord
  has_many :order_pizzas
  has_many :pizzas, through: :order_pizzas
  has_many :order_sides
  has_many :sides, through: :order_sides

  validates :total_price, presence: true
  
  validates :status, presence: true


end

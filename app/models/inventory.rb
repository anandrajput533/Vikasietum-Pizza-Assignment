class Inventory < ApplicationRecord
  validates :ingredient_name, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end

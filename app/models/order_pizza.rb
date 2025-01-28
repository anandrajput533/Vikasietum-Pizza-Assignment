class OrderPizza < ApplicationRecord

  belongs_to :order
  belongs_to :pizza
  

  validates :order, :pizza,  presence: true
  
end

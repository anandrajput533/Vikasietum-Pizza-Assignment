class Api::V1::MenuController < ApplicationController
  def index
    pizzas = Pizza.all
    crusts = Crust.all
    toppings = Topping.all
    sides = Side.all

    render json: {
      pizzas: pizzas,
      crusts: crusts,
      toppings: toppings,
      sides: sides
    }
  end

  def create
    pizza = Pizza.new(menu_params)
    if pizza.save
      render json: { message: "Pizza added successfully", pizza: pizza }, status: :created
    else
      render json: { error: pizza.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def menu_params
    params.require(:pizza).permit(:name, :size, :price, :is_vegetarian, :crust_id)
  end
end

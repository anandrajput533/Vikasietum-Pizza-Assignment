class Api::V1::OrdersController < ApplicationController

  def index
    orders = Order.all
    render json: orders, status: :ok
  end

  def create
    order = Order.new(order_params.except(:pizzas, :sides))

    if order_params[:pizzas].blank?
      return render json: { error: "Pizzas can't be blank" }, status: :unprocessable_entity
    elsif order_params[:sides].blank?
      return render json: { error: "Sides can't be blank" }, status: :unprocessable_entity
    end

    order.pizzas = Pizza.where(id: order_params[:pizzas].map { |pizza| pizza[:id] })
    order.sides = Side.where(id: order_params[:sides])

    order.pizzas.each_with_index do |pizza, index|
      topping_ids = order_params[:pizzas][index][:topping_ids]
      if topping_ids.present?
        pizza.toppings = Topping.where(id: topping_ids)
      end
    end

    order.total_price = calculate_total(order)
    order.status = "confirmed"

    if order.save
      render json: { message: "Order placed successfully", order: order }, status: :created
    else
      render json: { error: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def calculate_total(order)
    pizza_price = order.pizzas.sum(&:price)
    side_price = order.sides.sum(&:price)
    topping_price = order.pizzas.sum { |pizza| pizza.toppings.sum(&:price) }

    pizza_price + side_price + topping_price
  end
  
  def order_params
    params.require(:order).permit(
      pizzas: [:id, :size, :crust_id, topping_ids: []],
      sides: []
    )
  end
end

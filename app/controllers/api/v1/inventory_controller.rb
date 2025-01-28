class Api::V1::InventoryController < ApplicationController
  def index
    inventory = Inventory.all
    render json: inventory
  end

  def update
    Rails.logger.debug("Parameters received: #{params.inspect}")
    inventory = Inventory.find_by(ingredient_name: params[:ingredient_name])
    if inventory
      inventory.stock += params[:stock].to_i
      if inventory.save
        render json: { message: "Inventory updated successfully", inventory: inventory }, status: :ok
      else
        render json: { error: inventory.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    else
      render json: { error: "Ingredient not found" }, status: :not_found
    end
  end
end
  
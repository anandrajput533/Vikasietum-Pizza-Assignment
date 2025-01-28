require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  let!(:crust) { Crust.create!(name: "Thin") }
  let!(:topping1) { Topping.create!(name: "Cheese", price: 30) }
  let!(:topping2) { Topping.create!(name: "Olives", price: 25) }
  let!(:pizza) { Pizza.create!(name: "Deluxe Veggie", size: "Regular", price: 150, is_vegetarian: true, crust_id: crust.id, toppings: [topping1, topping2]) }
  let!(:side) { Side.create!(name: "Cold Drink", price: 55) }

  describe "POST /create" do
    context "when inventory is sufficient" do
      it "creates an order successfully" do
        order_params = {
          order: {
            pizzas: [{ id: pizza.id, size: "Regular", crust_id: crust.id, topping_ids: [topping1.id, topping2.id] }],
            sides: [side.id]
          }
        }

        post api_v1_orders_path, params: order_params, as: :json

        expect(response).to have_http_status(:created)

        response_body = JSON.parse(response.body)

        expected_total_price = 150 + 30 + 25 + 55
        expect(response_body["order"]["total_price"]).to eq(expected_total_price)
        expect(response_body["message"]).to eq("Order placed successfully")
      end
    end
  end
end

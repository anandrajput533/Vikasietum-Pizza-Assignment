require 'rails_helper'

RSpec.describe "Api::V1::Menu", type: :request do
  let!(:crust) { Crust.create!(name: "Thin") }
  let!(:topping1) { Topping.create!(name: "Cheese", price: 30) }
  let!(:topping2) { Topping.create!(name: "Olives", price: 25) }
  let!(:side) { Side.create!(name: "Cold Drink", price: 55) }
  let!(:pizza1) { Pizza.create!(name: "Margherita", size: "Medium", price: 10, is_vegetarian: true, crust: crust) }
  let!(:pizza2) { Pizza.create!(name: "Pepperoni", size: "Large", price: 12, is_vegetarian: false, crust: crust) }

  describe "GET /index" do
    it "retrieves all pizzas, crusts, toppings, and sides" do
      get "/api/v1/menu"

      expect(response).to have_http_status(:ok)

      response_body = JSON.parse(response.body)

      # Ensure pizzas are not empty
      expect(response_body["pizzas"]).not_to be_empty
      expect(response_body["pizzas"].length).to eq(2) # Expecting 2 pizzas
    end
  end

  describe "POST /create" do
    context "when pizza is valid" do
      it "creates a pizza successfully" do
        pizza_params = {
          pizza: {
            name: "Deluxe Veggie",
            size: "Regular",
            price: 150,
            is_vegetarian: true,
            crust_id: crust.id
          }
        }

        post "/api/v1/menu", params: pizza_params, as: :json

        expect(response).to have_http_status(:created)

        response_body = JSON.parse(response.body)

        expect(response_body["message"]).to eq("Pizza added successfully")
        expect(response_body["pizza"]["name"]).to eq("Deluxe Veggie")
        expect(response_body["pizza"]["size"]).to eq("Regular")
        expect(response_body["pizza"]["price"]).to eq(150)
        expect(response_body["pizza"]["is_vegetarian"]).to be(true)
      end
    end

    context "when pizza is invalid" do
      it "returns an error when pizza data is invalid" do
        pizza_params = {
          pizza: {
            name: "Deluxe Veggie",
            size: "Regular",
            is_vegetarian: true
          }
        }

        post "/api/v1/menu", params: pizza_params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)

        response_body = JSON.parse(response.body)

        expect(response_body["error"]).to include("Price can't be blank")
      end
    end
  end
end

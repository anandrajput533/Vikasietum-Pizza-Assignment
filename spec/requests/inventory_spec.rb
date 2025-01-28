require 'rails_helper'

RSpec.describe "Api::V1::Inventory", type: :request do
  let!(:inventory_item) { Inventory.create!(ingredient_name: "Cheese", stock: 100) }

  describe "GET /index" do
    it "retrieves all inventory items" do
      get "/api/v1/inventory"

      expect(response).to have_http_status(:ok)

      response_body = JSON.parse(response.body)
      expect(response_body).to be_an(Array)
      expect(response_body.size).to eq(1)

      expect(response_body[0]["ingredient_name"]).to eq("Cheese")
      expect(response_body[0]["stock"]).to eq(100)
    end
  end

  describe "PUT /update" do
    context "when the ingredient exists" do
      it "updates the inventory stock successfully" do
        update_params = {
          ingredient_name: "Cheese",
          stock: 20
        }

        put "/api/v1/inventory/update", params: update_params, as: :json

        expect(response).to have_http_status(:ok)

        response_body = JSON.parse(response.body)
        expect(response_body["message"]).to eq("Inventory updated successfully")
        expect(response_body["inventory"]["ingredient_name"]).to eq("Cheese")
        expect(response_body["inventory"]["stock"]).to eq(120) # Original 100 + 20
      end
    end

  
    describe "PUT /update" do
      context "when the ingredient does not exist" do
        it "returns a not found error" do
          update_params = {
            ingredient_name: "Pepperoni",
            stock: 10
          }
  
          put "/api/v1/inventory/update", params: update_params, as: :json
  
          expect(response).to have_http_status(:not_found)
  
          response_body = JSON.parse(response.body)
          expect(response_body["error"]).to eq("Ingredient not found")
        end
      end
    end  

    
   

    context "when the stock update fails validation" do
      it "returns a validation error" do
        update_params = {
          ingredient_name: "Cheese",
          stock: -200
        }

        put "/api/v1/inventory/update", params: update_params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)

        response_body = JSON.parse(response.body)
        expect(response_body["error"]).to include("Stock must be greater than or equal to 0")
      end
    end
  end
end

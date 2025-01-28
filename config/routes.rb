Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :menu, only: [:index, :create, :update]
      resources :orders, only: [:create, :show, :index]
      resources :inventory, only: [:update, :index]
    end
  end
end

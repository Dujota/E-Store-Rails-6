Rails.application.routes.draw do
  resources :orders
  resources :line_items do
    member do
      post "decrement_quantity"
    end
  end
  resources :carts
  root "store#index", as: "store-index"

  resources :products
end

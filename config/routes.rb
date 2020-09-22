Rails.application.routes.draw do
  root "store#index", as: "store-index"

  resources :products
end

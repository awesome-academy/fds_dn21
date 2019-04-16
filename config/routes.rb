Rails.application.routes.draw do

  root "static_pages#home"

  get "/contact", to: "static_pages#contact"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/admin", to: "admin/admins#index"
  get "/welcome", to: "client/clients#index"

  resources :users
  resources :products
  resources :categories

  namespace :admin do
    root "admins#index"
    resources :users
    resources :categories
    resources :products
  end

  namespace :client do
    root "clients#index"
    resources :carts
  end

end

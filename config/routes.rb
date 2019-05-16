Rails.application.routes.draw do

  root "categories#index"

  devise_for :users, controllers: {
    registrations: "registrations",
    sessions: "sessions",
    passwords: "passwords",
    confirmations: "confirmations"
  }

  get "/contact", to: "static_pages#contact"

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
    resources :orders, only: [:create, :index]
    resources :rates, only: :create
  end

end

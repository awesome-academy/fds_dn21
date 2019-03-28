Rails.application.routes.draw do

  root "static_pages#home"
  
  get "/contact", to: "static_pages#contact"
  get "static_pages/signup"
  get "static_pages/signin"

end

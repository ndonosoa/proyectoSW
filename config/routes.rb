Rails.application.routes.draw do


  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :brands
	resources :regions
  resources :products
  resources :users
  resources :providers
  resources :cities
  resources :categories
  resources :homes
  resources :prices
  resources :stocks
root 'home#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

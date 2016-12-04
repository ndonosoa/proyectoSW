Rails.application.routes.draw do

	resources :regions
  resources :users
  resources :providers
  resources :cities
  resources :categories
root 'users#new'

=begin
  get 'regions/index'

  get 'regions/new'

  get 'regions/create'

  get 'regions/show'

  get 'regions/update'

  get 'regions/delete'
=end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

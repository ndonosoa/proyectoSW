Rails.application.routes.draw do

	resources :regions
   get 'regions/create'
  resources :users
  resources :providers
  resources :cities
  resources :categories
root 'regions#index'

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

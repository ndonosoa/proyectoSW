Rails.application.routes.draw do


=begin  get 'regions', to:'regions#index'
  
  get '/regions/:id/edit', to: 'regions#editar'
=end 
  get '/regions/json/getregions', to: 'regions#getregions'
  get '/regions/json/geterrorregions', to: 'regions#create'
  resources :regions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #Product Routes
	get '/products/json/getproducts', to: 'products#asd'
	resources :products


  #Brand Routes
  		get '/brands/json/getbrands', to: 'brands#getbrands'
  		resources :brands

  #Category Routes
      get '/categories/json/getcategories', to: 'categories#getcategories'
      resources :categories

  #Provider Routes
      get '/providers/json/getproviders', to: 'providers#getproviders'
      get '/providers/json/getcities', to: 'providers#getcities'
      resources :providers

  #Rutas comuna
      get '/comunas/json/getcomunas', to: 'comunas#getcomunas'
      resources :comunas

  #Purchases Routes
      get '/purchases/json/getproductosorden/:id', to: 'purchases#getproductosorden'
      get 'purchases/json/revisarjson', to:'purchases#revisarjson'
      resources :purchases

  #Users routes
      get '/users/json/getusers', to: 'users#getusers'
      put '/users/update/:id', to: 'users#updateuser'
      put '/users/delete/:id', to: 'users#softdeleteuser'
      resources :users

  #Login Routes
       get '/login', to: 'sessions#new'
       post '/login', to: 'sessions#create'
       get '/logout', to: 'sessions#destroy'

  #Home route
  root 'home#index'
end

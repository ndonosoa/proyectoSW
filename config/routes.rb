Rails.application.routes.draw do


=begin  get 'regions', to:'regions#index'
  
  get '/regions/:id/edit', to: 'regions#editar'
=end 
  get '/regions/json/getregions', to: 'regions#getregions'
  get '/regions/json/geterrorregions', to: 'regions#create'
  put '/regions/delete/:id', to: 'regions#softdelete'
  resources :regions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #Product Routes
	get '/products/json/getproducts', to: 'products#asd'
  get '/products/json/gethistorial/:id', to: 'products#gethistorial'
  get '/products/json/gethistoriald/:id', to: 'products#gethistoriald'
	resources :products


  #Brand Routes
  		get '/brands/json/getbrands', to: 'brands#getbrands'
      put '/brands/delete/:id', to: 'brands#softdelete'
  		resources :brands

  #Category Routes
      get '/categories/json/getcategories', to: 'categories#getcategories'
      put '/categories/delete/:id', to: 'categories#softdelete'
      resources :categories

  #Provider Routes
      get '/providers/json/getproviders', to: 'providers#getproviders'
      get '/providers/json/getcities', to: 'providers#getcities'
      put '/providers/delete/:id', to: 'providers#softdeleteprovider'
      get '/providers', to: 'providers#index'
      get '/provider/new', to: 'providers#new'
      post '/providers', to: 'providers#create'
      get '/providers/:id/edit', to: 'providers#edit'
      put '/providers/:id', to: 'providers#update'
      #resources :providers

  #Rutas comuna
      get '/comunas/json/getcomunas', to: 'comunas#getcomunas'
      put '/comunas/delete/:id', to: 'comunas#softdelete'
      resources :comunas

  #Purchases Routes
      get '/purchases/json/getproductosorden/:id', to: 'purchases#getproductosorden'
      get '/purchases/json/getpurchases', to: 'purchases#getpurchases'
      get '/purchases/json/getpurchasesd', to: 'purchases#getpurchasesd'
      post '/purchases', to:'purchases#create'
      get '/purchases/new', to: 'purchases#new'
      get '/purchases', to: 'purchases#index'
      get '/purchases/json/getdetalleorden/:id', to: 'purchases#getdetalleorden'
      put '/purchases/updatedetail/:id', to: 'purchases#updatedetail'
      put '/purchases/delete/:id', to: 'purchases#softdelete'
      #resources :purchases

  #Users routes
      get '/users/json/getusers', to: 'users#getusers'
      patch '/users/update/:id', to: 'users#updateuser'
      put '/users/delete/:id', to: 'users#softdeleteuser'
      put '/users/updatemail/:id', to: 'users#updatemail'
      resources :users

  #Login Routes
       get '/login', to: 'sessions#new'
       post '/login', to: 'sessions#create'
       get '/logout', to: 'sessions#destroy'

  #Home route
  root 'home#index'
end

# File designated for setting up routes

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Routing for model actions (CRUD), textbooks
  resources :textbooks, controller: 'textbook'

  # Routing for model actions (CRUD), books
  resources :books

  # Routing for model actions (CRUD), offers
  resources :offers, controller: 'offer'

  # Routing for model actions (CRUD), users
  resources :users

  # Routing for model actions (CRUD), manufacturers
  get 'manufacturers/get-existing-manufacturer', to: 'manufacturers#get_existing_manufacturer_by_name'

  resources :manufacturers


  # Routing for model actions (CRUD), pending offers
  resources :pendingoffers

  # authentication routes for application.
  post 'authenticate', to: 'authentication#authenticate'

  get 'authenticated-user', to: 'users#getuser'

  put 'update-authenticated-user', to: 'users#updateuser'

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :textbooks, controller: 'textbook'
  resources :books
  resources :offers, controller: 'offer'

  resources :users


  get 'manufacturers/get-existing-manufacturer', to: 'manufacturers#get_existing_manufacturer_by_name'

  resources :manufacturers



  resources :pendingoffers

  # Authenticate route
  post 'authenticate', to: 'authentication#authenticate'

  get 'authenticated-user', to: 'users#getuser'

  put 'update-authenticated-user', to: 'users#updateuser'

end

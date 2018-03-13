Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :textbooks, controller: 'textbook'
  resources :books
  resources :offers, controller: 'offer'

  resources :manufacturers

end
